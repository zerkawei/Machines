using System.Collections;
namespace Machines;

public abstract class SourceMachine<T, D>
{
	protected StateGraph<T, D> states;
	protected T source;

	public this(StateGraph<T, D> states, T source)
	{
		this.states = states;
		this.source = source; 
	}

	public void Run()
	{
		Reset();
		RunAfterReset();
	}

	public virtual D InitCursorData()
	{
		return default;
	}

	public abstract void Reset();

	protected abstract bool HandleStuckCursor(Cursor<T, D> cursor);

	protected abstract void RunAfterReset();

	protected abstract void Accept(D data);

}