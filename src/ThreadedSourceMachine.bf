using System.Threading;
namespace Machines;

public abstract class ThreadedSourceMachine<T, D> : SourceMachine<T, D>
{
	public this(StateGraph<T, D> states, T source) : base(states, source) {}

	public override void Run()
	{
		RunCursor(new .(states.Start, InitCursorData()));
	}

	private void RunCursor(Cursor<T, D> cursor)
	{
		var hasTransitioned = true;
		while(hasTransitioned)
		{
			if(cursor.Current.IsAccepting)
			{
				Accept(cursor.Data);
			}

			Transition<T, D> firstTransition = null;
			for(let transition in cursor.Current.Transitions)
			{
			    if(transition.Available(cursor, source))
				{
					if(firstTransition != null)
					{
						let nCur = new Cursor<T, D>(cursor);
						transition.Apply(nCur);

						let thread = scope:: Thread(new (x) => RunCursor((.)x));
						thread.Start(nCur, false);
						defer:: thread.Join();
					}
					else { firstTransition = transition; }
				}
			}

			if(firstTransition != null)
			{
				firstTransition.Apply(cursor);
			}
			else
			{
				hasTransitioned = HandleStuckCursor(cursor);
			}
		}
		delete cursor;
	}
}