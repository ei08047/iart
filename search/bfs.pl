% Autor:
% Data: 20/06/2015

  graph([a,b,c,d,e,f],[e(a,b),e(a,c),e(c,d),e(d,f),e(d,e), e(e,f)]).


   expand(Elem,EdgeList,Sucessors):-  findall(Sucessor, ( member(e(Elem,Sucessor),EdgeList) ; member(e(Sucessor,Elem) , EdgeList) ), Sucessors) .
   
   go(Initial,Goal):-
        graph(NodeList,EdgeList),
        expand(Initial,EdgeList,Sucessors),
        bfs(Initial,Goal,Sucessors,[Initial]).


   bfs(Initial,Goal,[],Explored):-write('Explored:  '), write(Explored),nl.
   bfs(Initial,Goal,[H|T],Explored):-
                 graph(NodeList,EdgeList),
                (  not( member(H,Explored) ) *->
                 expand(H,EdgeList,Sucessors),
                 append(T,Sucessors,T2),
                 append([H],Explored,Explored2),
                 bfs(Initial,Goal,T2,Explored2),! ) ;
                 bfs(Initial,Goal,T,Explored),!.
                 
                 
                 
                 
                 
  test:- go(a,f).