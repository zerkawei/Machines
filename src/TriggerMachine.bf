namespace Machines;

public class TriggerMachine<T, D>
{
	private StateGraph<T, D> states;
	private Cursor<T, D> cursor ~ delete _;

	public State<T, D> CurrentState => cursor.Current;
	public D CurrentData => cursor.Data;

	public this(StateGraph<T,D> states)
	{
		this.states = states;
		this.cursor = new .(states.Start, InitCursorData());
	}

	public virtual D InitCursorData()
	{
		return default;
	}

	public void Trigger(T trigger)
	{
		for(let transition in CurrentState.Transitions)
		{
			if(transition.Available(cursor, trigger))
			{
				transition.Apply(cursor);
				return;
			}
		}
	}
}