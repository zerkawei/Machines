using System.Collections;
namespace Machines;

public abstract class SourceMachine<T, D> where D : struct
{
	protected StateGraph<T, D> states;
	protected T source;

	public this(StateGraph<T, D> states, T source)
	{
		this.states = states;
		this.source = source;
	}

	public virtual D InitCursorData()
	{
		return default;
	}

	public abstract void Run();

	public abstract bool HandleStuckCursor(Cursor<T, D> cursor);

	protected abstract void Accept(D data);

}