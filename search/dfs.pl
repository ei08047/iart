% Autor: Zé
% Data: 19/06/2015
% Subject: DFS

   graph([a,b,c,d,e,f],[e(a,b),e(a,c),e(c,d),e(d,f),e(d,e), e(e,f)]).
   
   
   expand(Elem,EdgeList,Next):-   member(e(Elem,Next),EdgeList) ; member(e(Next,Elem), EdgeList).
   
   
 %%  1  procedure DFS(G,v):
 %%  2      label v as discovered
 %%  3      for all edges from v to w in G.adjacentEdges(v) do
 %%  4          if vertex w is not labeled as discovered then
 %%  5              recursively call DFS(G,w)
   

   go(Initial,Goal):-
     append([],[Initial],Explored),
     dfs(Initial,Goal,Explored).
     
   dfs(Goal,Goal,Explored):-write('Explored:  '), write(Explored),nl.
   
   dfs(Initial,Goal,Explored):-
                 graph(NodeList,EdgeList),
                 expand(Initial,EdgeList,Next),
                 not(member(Next,Explored)),
                 append(Explored,[Next],Explored2),
                 dfs(Next,Goal,Explored2),!.
                 

    test:- go(a,f).