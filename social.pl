read_routine(L):-
read_line_to_codes(user_input, Input),
atom_codes(Atom, Input),
atomic_list_concat(L, ' ' ,Atom),
print(L).

s(s(NP,VP)) --> np(NP), vp(VP).
np(np(DET,N)) --> det(DET,Genero), n(N,Genero).
vp(vp(V,NP)) --> tv(V,Acc), np(NP).
vp(vp(V)) --> v(V).

det(det(Word),Genero) --> [Word],{lex(Word,det,Genero)}.
n(n(Word),Genero) --> [Word],{lex(Word,n,Genero)}.
v(v(Word)) --> [Word],{lex(Word,v)}.
tv(tv(Word),Acc)--> [Word],{lex(Word,tv,Acc),write(Acc)}.

pessoa(1,'Pedro',20,m).
pessoa(2,'Ana',22,f).
pessoa(3,'Joao',18,m).
pessoa(4,'Rita',28,f).

amigos(1,[2,3]).
amigos(2,[1,4]).
amigos(3,[1]).
amigos(4,[2]).


ser_amigo(A,B):- pessoa(Id1, A,_,_) , pessoa(Id2, B, _,_) , amigos(Id1, L1), member(Id2, L1).
em_comum(A,B,L):- pessoa(Id1, A,_,_) , pessoa(Id2, B, _,_), amigos(Id1, L1), amigos(Id2, L2), findall(X,(member(X,L1),member(X,L2)),L).


%%%lexico
%%% determinantes
lex(a,det,f).
lex('o',det,m).
lex(do,det,m).

lex('escritor',n,m).
lex(joao,n,m).
lex(pedro,n,m).
lex(escritora,n,f).
lex('escreveu',tv).
lex('e',tv,'ser').
lex('são',tv,'ser').
lex('livro',n,m).
lex(sao,tv).
lex(amigo,n,m).
lex(amigos,n,m).
lex(amiga,n,f).
lex(pertence,tv).


test:- split_string('Olá Mundo',' ',' ',L), write(L).
test2:- read_routine(X), s(L,X,[]), write(L).
%%%%s(L,['o','joao','e','amigo','do','pedro'],[]),write(L).
test3:- s(L,['o','escritor','e','o','livro'],[]),write(L).