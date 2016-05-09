read_routine(L):-
read_line_to_codes(user_input, Input),
atom_codes(Atom, Input),
atomic_list_concat(L, ' ' ,Atom),
print(L).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAMATICA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(s(NP,VP)) --> np(NP), vp(VP).
s(s(I,NP,VP)) --> int(I) , vp(VP).


np(np(DET,N)) --> det(DET,Genero), n(N,Genero).
np(np(N1,N2)) --> n(N1,_), n(N2,_).
vp(vp(V,NP)) --> tv(V,Acc), np(NP).
vp(vp(V,Mod,NP)) --> tv(V,Acc), mod(Mod), np(NP).
vp(vp(V)) --> v(V).

mod(mod(ADV,DET,PRO))--> adv(ADV) , det(DET,_), pro(PRO).


det(det(Word),Genero) --> [Word],{lex(Word,det,Genero)}.
n(n(Word),Genero) --> [Word],{lex(Word,n,Genero)}.
v(v(Word)) --> [Word],{lex(Word,v)}.
tv(tv(Word),Acc)--> [Word],{lex(Word,tv,Acc)}.
adv(adv(Word)) --> [Word],{lex(Word,adv)}.
pro(pro(Word)) --> [Word], { lex(Word, p, _ )}.
int(int(Word) ) --> [Word] , { lex(Word,p,_) }.






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%KnowledgeBase%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lexicon%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% determinantes
lex(a,det,f).
lex('o',det,m).
lex('do',det,m).
lex('de',det,_).

%%%nomes
lex(joao,n,m).
lex(pedro,n,m).
lex(amigo,n,m).
lex(amigos,n,m).
lex(amiga,n,f).

lex('25',n , m).

lex('anos' , n , m ).



%%%verbos

lex('e',tv,'ser').
lex('são',tv,'ser').
lex('ter', tv, 'ter').
lex(pertence,tv).

%%%
lex('mais', adv ).

%%%pronomes
lex(quantos, p , m).
lex('que', p , _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Testes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test1 :- s(N, [ 'quantos', 'ter', 'mais', 'de','que', '25', 'anos'],[]),write(N).
test2 :- s(N, [ 'quantos', 'têm', 'mais', 'do', 'que', '25', 'anos'],[]),write(N).
np_test2 :- np(N, ['maior', 'de', 'idade']).

test3:- s(L,['o','escritor','e','o','livro'],[]),write(L).