% Autor:
% Data: 14/04/2013
        %%gramatica de verbos transitivos
s(s(NP,VP)) --> np(NP), vp(VP).
np(np(DET,N)) --> det(DET,Genero), n(N,Genero).
vp(vp(V,NP)) --> tv(V), np(NP).
vp(vp(V)) --> v(V).

det(det(Word),Genero) --> [Word],{lex(Word,det,Genero)}.
n(n(Word),Genero) --> [Word],{lex(Word,n,Genero)}.
v(v(Word)) --> [Word],{lex(Word,v)}.
tv(tv(Word))--> [Word],{lex(Word,tv)}.

lex(a,det,f).
lex(o,det,m).
lex(escritor,n,m).
lex(escritora,n,f).
lex(escreveu,tv).
lex(livro,n,m).

test:- s(L,['o','escritor','escreveu','o','livro'],[]),write(L).