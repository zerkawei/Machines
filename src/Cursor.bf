namespace Machines;

public class Cursor<T> : Cursor<T, void>;
public class Cursor<T, D> where D : struct
{
	private D data;

	public ref D Data => ref data;
	public State<T,D> Current { get; set; }

	public this(State<T, D> current, D data)
	{
		Current = current;
		this.data = data;
	}

	public this(Self cursor) : this(cursor.Current, cursor.data) {}
	public this(State<T, D> current) : this(current, default) {}
}

public interface IPositioned
{
	public int Position { get; set mut; }
}