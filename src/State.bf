using System.Collections;
namespace Machines;

public class State<T, D> where D : struct
{
	public bool IsAccepting { get; }
	public List<Transition<T, D>> Transitions { get; }

	public this(bool isAccepting, params Transition<T, D>[] transitions)
	{
		IsAccepting = isAccepting;
		Transitions = new .(transitions.Count);
		for(let t in transitions)
		{
			Transitions.Add(t);
		}
	}

	public ~this()
	{
		for(let t in Transitions)
		{
			delete t;
		}
		delete Transitions;
	}	
}