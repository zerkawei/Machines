using System.Collections;
namespace Machines;

public abstract class SteppedSourceMachine<T, D> : SourceMachine<T, D> where D : struct
{
	private List<Cursor<T, D>> cursors ~ DeleteContainerAndItems!(_);

	public this(StateGraph<T, D> states, T source) : base(states, source)
	{
		this.cursors = new .();
		Reset();
	}

	public virtual void Reset()
	{
		cursors.ClearAndDeleteItems();
		cursors.Add(new .(states.Start, InitCursorData()));
	}

	public override void Run()
	{
		while(StepAll()) {}
	}

	public bool StepAll()
	{
		var i = 0;
		while(i < cursors.Count)
		{
			var cursor = cursors[i];
			if(cursor.Current.IsAccepting)
			{
				Accept(cursor.Data);
			}
			if(!Step(cursor))
			{
				delete cursor;
				cursors.RemoveAt(i);
			}
			else { i++; }
		}
		return cursors.Count > 0;
	}

	private bool Step(Cursor<T, D> cursor)
	{
		Transition<T, D> firstTransition = null;

		for(let transition in cursor.Current.Transitions)
		{
		    if(transition.Available(cursor, source))
			{
				if(firstTransition != null)
				{
					let nCur = new Cursor<T, D>(cursor);
					transition.Apply(nCur);
					cursors.Add(nCur);
				}
				else { firstTransition = transition; }
			}
		}

		if(firstTransition != null)
		{
			firstTransition.Apply(cursor);
			return true;
		}

		return HandleStuckCursor(cursor);
	}
}