% Autor: Zé
% Data: 21/06/2015
% Subject: Best first search


graph([h(arad,366), h(bucharest,0), h(craiova,160), h(dobreta,242), h(fagaras,178), h(lugoj,244), h(mehadia,241), h(oradea,380),
h(pitesti,98), h(rimnicu,193) , h(sibiu,253) , h(timisoara,329) , h(zerind,374) ],
[e(oradea,zerind,71) , e(oradea,sibiu,151) , e(zerind,arad,75) , e(arad,sibiu,140) , e(arad,timisoara,118) , e(sibiu,fagaras,99) , e(sibiu,rimnicu,80) ,
 e(timisoara,lugoj,111) , e(lugoj,mehadia,70) , e(mehadia,dobreta,75) , e(dobreta,craiova,120) , e(rimnicu,craiova,146) , e(rimnicu,pitesti,97),
  e(craiova,pitesti,138) , e(pitesti,bucharest,101) , e(fagaras,bucharest,211)]).
  
  
 expand(Elem,EdgeList,Sucessors):-                                                                                  %%%get all sucessors
  findall(Sucessor, ( member(e(Elem,Sucessor,_),EdgeList) ; member(e(Sucessor,Elem,_) , EdgeList) ), Sucessors) .
  
 get_h([h(Elem,H) | _],Elem,H).              %%get heuristic value H of element Elem
  get_h([_| T],Elem,H):-get_h(T,Elem,H).
  
  
  %%order_open(Open,)
  
  %%add_to_parentList(Parent, Node,ParentList,NewParentList)
  
  %% if in closed list do nothing, else put in open list and re-order it.
  %%process
  
  bfs(Goal,Open,Closed,ParentList):- member(Goal,Open),!.
  bfs(Goal,[],Closed,ParentList):-write('ended'),nl,!.
    bfs(Goal,[H|T],Closed,ParentList):-
    graph(Node_h,EdgeList),
     get_h(Node_h,H,Value),
    write('expanding : '), write( H ),write('  with h value : '),write(Value),nl,
    expand(H,EdgeList,Sucessors),
    append(Closed,[H],NewClosed),

    write(Sucessors),nl.
    
    
    
    go(Initial,Goal):-
           bfs(Goal,[Initial],[],[start-Initial]),!.
           
           
           test:-go(oradea,bucharest).

