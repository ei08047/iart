% Autor:
% Data: 18/06/2015

%%move cost
g(_,1).

h([],_,ManList,ManList).
h([P1|Pt],Goal,Temp,ManList):-
    manhatan_distance(P1,Goal,M),
    append(Temp, [M ], Temp2),
    h(Pt,Goal,Temp2,ManList).
    
    
%%f(H,G,F):-

check_parent(Possible,Man,Parent).

order_key_Val_List(Key,ValueList,OrderedList):- key_val_list(Key,ValueList,[],KeyVal), keysort(KeyVal, OrderedList) .

key_val_list([ ],[],KeyVal,KeyVal).
key_val_list([KeyHead | KeyTail ],[ValueListHead | ValueListTail],Temp,KeyVal):- append(Temp, [ValueListHead-KeyHead],Temp2), key_val_list(KeyTail,ValueListTail,Temp2,KeyVal).


open(L, [] ,[],Temp,L2):-append(L,Temp,L2).
open(L, [H | T] ,[Hm|Tm],Temp,L2):-
         append(Temp,[H-Hm],Temp2),
         open(L,T,Tm,Temp2,L2).
         
         
%%order_open([Pos-Val | T],)


closed(L,[L-0]).
add_closed(L,Elem,L2):-
append(L,[Elem],L2).



astar_init:-
boardPos(PosList),board(PieceList),                                                      %%get the boards
          param_board2(PosList,ParamPos),param_board2(PieceList,ParamPiece),                     %%param the boards
         get_all_sources(ParamPos,ParamPiece,1,[],SourcesList), !,                                                   %%%get sources
            get_all_moves_source_list(PosList ,PieceList, 1,SourcesList,[],[Initial- Possible | []]),!,                %%get Moves for sources
            closed(Initial,ClosedList),                                %%init closed list
            goal(1,Goal),                                             %%get goal
            h(Possible,Goal,[],Man),                               %%get h value
            order_key_Val_List(Possible,Man,OpenList),              %%  order open list
           %% open([],Possible,Man,[],OpenList),
            write('finished a* init'),nl,
            astar(PieceList,ClosedList,OpenList,Goal,[Initial]).                %%re call astar
            
            
  astar(PieceBoard,Closed, [Pos-Val | T] ,Goal,Parent ):-
             boardPos(PosBoard),
             write('here'),nl,
             generate_board(PosBoard,PieceBoard,Parent,Pos,NewBoard),   %%generate board
              param_board2(PosList,ParamPos),param_board2(NewBoard,ParamPiece),      %%param the boards
                 get_all_sources(ParamPos,ParamPiece,1,[],SourcesList), !,   %%%get sources
                 get_all_moves_source_list(PosList ,PieceList, 1,SourcesList,[],[_Parent- Possible | []]),  !,  %%get Moves for sources
                 write('Possible  '),write(Possible),nl,
                   %%add_closed(Closed,[Pos-Val],Closed2), %%update closed list                                           %%get goal
                     %% h(Possible,Goal,[],Man),  %%get h value
                     %% check_parent(Possible,Man,Parent),                          %%re parent open list
                                                   %%  order open list
                    %%  open(T, Possible ,Man,[],NewOpen),                             %%%add to open list
                    %%re call astar
  write('Closed  '),write(Closed),nl,
 %% write('NewOpen  '),write(NewOpen),nl,
  write('Parent  '),write(Parent),nl.
  
  



