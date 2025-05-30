using System.Collections;
namespace Machines;

public class State<T, D>
{
	public bool IsAccepting { get; set; }
	public List<Transition<T, D>> Transitions { get; }

	public this(bool isAccepting = false, params Transition<T, D>[] transitions)
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