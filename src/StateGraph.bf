using System;
using System.Collections;
namespace Machines;

public struct StateGraph<T, D> : IDisposable
{
	public State<T, D> Start;

	public this(State<T, D> start)
	{
		Start = start;
	}

	public void Dispose()
	{
		HashSet<State<T,D>> visited = scope .();
		void Visit(State<T,D> s)
		{
			visited.Add(s);
			for(let t in s.Transitions)
			{
				if(!visited.Contains(t.Target))
				{
					Visit(t.Target);
				}
			}
		}
		Visit(Start);
		visited.ClearAndDelete();
	}
}