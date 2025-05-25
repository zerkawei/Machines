namespace Machines;

public abstract class Transition<T> : Transition<T, void>;
public abstract class Transition<T, D>
{
	public State<T, D> Target { get; }

	public this(State<T, D> target)
	{
		Target = target;
	}

	public abstract bool Available(Cursor<T, D> cursor, T data);
	public virtual void Apply(Cursor<T, D> cursor)
	{
		cursor.Current = Target;
	}
}

public abstract class StepTransition<T, D> : Transition<T, D> where D : IPositioned
{
	public abstract int Step { get; }

	public this(State<T, D> target) : base(target) {}

	public override void Apply(Cursor<T, D> cursor)
	{
		base.Apply(cursor);
		cursor.Data.Position += Step;
	}
}