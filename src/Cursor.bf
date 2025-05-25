using System;
namespace Machines;

public class Cursor<T> : Cursor<T, void>;
public class Cursor<T, D>
{
	private D data;

	public ref D Data => ref data;
	public State<T, D> Current { get; set; }

	public this(State<T, D> current, D data)
	{
		Current = current;
		this.data = data;
	}
	public this(State<T, D> current) : this(current, default) {}
	public virtual this(Self copy) : this(copy.Current) {}
}

public extension Cursor<T, D> where D : struct
{
	public override this(Self copy) : this(copy.Current, copy.data) {}
}

public extension Cursor<T, D> where D : IClonable, Object, delete
{
	public override this(Self copy) : this(copy.Current, copy.data.Clone(.. new D())) {}
	public ~this()
	{
		delete data;
	}
}

public interface IPositioned
{
	public int Position { get; set mut; }
}

public interface IClonable
{
	public void Clone(Self Target);
}