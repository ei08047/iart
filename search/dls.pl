% Autor:  Zé
% Data: 20/06/2015
% Subject: Deapth Limit Search

graph([a,b,c,d,e,f],[e(a,b),e(a,c),e(c,d),e(d,f),e(d,e), e(e,f)]).

   expand(Elem,EdgeList,Sucessors):-  findall(Sucessor, ( member(e(Elem,Sucessor),EdgeList) ; member(e(Sucessor,Elem) , EdgeList) ), Sucessors) .

 %% 1  Determine the vertex where the search should start and assign the maximum search depth
%%  2 Check if the current vertex is the goal state
%%If not: Do nothing
%%If yes: return
%% 3 Check if the current vertex is within the maximum search depth
%%If not: Do nothing
%%If yes:
%%  Expand the vertex and save all of its successors in a stack
%%  Call DLS recursively for all vertices of the stack and go back to Step 2


   go(Initial,Goal,Limit):-
       graph(NodeList,EdgeList),
           expand(Initial,EdgeList,Sucessors),
            write('initial stack  '), write(Sucessors),nl,
      dls(Goal,0,Limit, Sucessors,[Initial]).

    dls(Goal,Limit,Limit,Stack,Closed):-write('reached limit'),nl,!.
    dls(Goal,It,Limit,Stack,Closed):-member(Goal,Stack),write('found  '),nl,!.
    dls(Goal,It,Limit,[H|T],Closed):-
          It < Limit,
          graph(NodeList,EdgeList),
           expand(H,EdgeList,Sucessors),
           
           append(T,Sucessors,Stack2),
           write('next stack  '), write(Stack2),nl,
           It2 is It + 1,
           dls(Goal,It2,Limit,Stack2) ,!.

  test:-go(a,f,2).