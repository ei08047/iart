
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Lexicon%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Word Type Gender
%%%%%%	PRONOMES INTERR	%%%%%%
lex(quantos,quantity,pro,m,p).
lex(quais,enumeration,pro,_,p).

%%%%%%	CONJUNÇÔES	%%%%%%
lex(e,con,_,_).
lex(em,con,_,_).
%%%%%%	DETERMINANTES	%%%%%%
lex(o,det,m,s).
lex(os,det,m,p).
lex(a,det,f,s).
lex(do,det,m,s).
lex(da,det,f,s).
%%%%%%	NOMES	%%%%%%
lex('joão',n,m,s).
lex(ana,n,f,s).
lex(pedro,n,m,s).
lex('zé',n,m,s).
lex('rita',n,f,s).
%%%%%%	ADJECTIVOS	%%%%%%
lex('amigo',friend, adj,m,s).
lex('amiga',friend, adj,f,s).
lex('amigas', friend,adj,f,p).
lex('amigos', friend,adj,m,p).
lex('comum',comum, adj,_,_).
%%%%%%	VERBOS	%%%%%%
lex('é',v,_,s).
lex('são',v,_,p).
lex('tem',v,_,s).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sintatica%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% High Level %%%%%
s(s(NP,VP),i(Relation,Suj,Obj) ) --> np(NP,Gen,s,Suj), vp(VP,Gen,s,Relation,Obj).
s(s(NP,VP),i(Relation,SujList)) --> np_(NP,Gen,p,SujList), vp(VP,Gen,p,Relation).
s(s(VP,NP),i(Modifier,Relation,Suj)) --> vp(VP,_,_,Modifier,Relation),np(NP,_,_,Suj).
s(s(VP,NP),i(Modifier,Relation,SujList)) --> vp(VP,_,Num,Modifier,Relation),np_(NP,_,Num1,SujList).

np(np(DET,N),Gen,Num,Suj) --> det(DET,Gen,Num), n(N,Gen,Num,Suj).    
np_(np(NP1,C,NP2),Gen,_,SujList) -->  np(NP1,GenA,_,A),con(C), np(NP2,GenB,_,B),{ getGender(GenA,GenB,Gen), append([A],[B],SujList)}.     	

np(np(Adj,DET,N),Gen1,pos,Relation,Suj) --> adj(Adj,Gen1,_,Relation) , det(DET,Gen,Num), n(N,Gen,Num,Suj).     

vp(vp(V,NP),Gen,Num,Relation,Suj) --> v(V,Num), np(NP,Gen,pos,Relation,Suj).
vp(vp(V,Adj),Gen,Num,Relation) --> v(V,Num),adj(Adj,Gen,Num,Relation) .
vp(vp(I,Adj,V),_,Num,Modifier,Relation) --> p(I,Modifier,Gen,Num1), adj(Adj,Gen,Num1,Relation) ,v(V,Num).

vp(vp(I,EXP,V),_,Num,Modifier,Relation) --> p(I,Modifier,_,Num),v(V,Num),test(EXP,Relation).

test(test(DET,Adj),Relation) --> det(DET,Gen,Num), adj(Adj,Gen,Num,Relation). 
test(test(DET,Adj1,C,Adj2),Relation) --> det(DET,Gen,Num), adj(Adj1,Gen,Num,_), con(C),adj(Adj2,_,_,Relation).

%%%%% Low Level %%%%%
det(det(Word),Gen,Num) --> [Code],{compare_to_lex(Code,Word,det,Gen,Num)}.
n(n(Word),Gen,Num , Suj) --> [Code],{compare_to_lex(Code,Word,n,Gen,Num),pessoa(Suj,Word,_,Gen)}.
v(v(Word),Num) --> [Code],{compare_to_lex(Code,Word,v,_,Num)}.
adj(adj(Word),Gen,Num,Meaning) --> [Code], { compare_to_lex(Code,Word,Meaning,adj,Gen,Num)}.
p(p(Word),Modifier,Gen,Num) --> [Code], { compare_to_lex(Code,Word,Modifier,pro,Gen,Num)}.
con(con(Word)) --> [Code], { compare_to_lex(Code,Word,con,_,_)}.
%%%


concorda_frase(Acc,Suj,Obj):- Pred =.. [Acc,Suj,Obj] ,! ,  Pred.
%%%
parser_test:-
				sentence(S),
				parse_sentence(S,L), 
				write('parsed sentence  '),nl,
				write(L),nl,
				sentence_to_codes(L,[],C),
				write('coded sentence  '),nl,
				write(C),nl,
				s(T,I, C , [] ) ,
				write('intermediate representation '),nl,
				write(T),nl,
				write('high level representation '),nl,
				write(I),nl.

%%%write(T),nl,
%%%write('Suj: ') , write(Suj),nl,
%%%write('Obj: '), write(Obj), nl,
%%%write('Acc: '), write(Acc).



%%concorda_test:-   s(T,Suj,Obj , Acc ,  ['o', 'joão', 'é', 'amigo', 'do', 'pedro'] , [] ) , 
%%				  concorda_frase(Acc,Suj,Obj).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%KnowledgeBase%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pessoa(1,'pedro',20,m).
pessoa(2,'ana',22,f).
pessoa(3,'joao',18,m).
pessoa(4,'rita',28,f).
pessoa(5,'zé',27,m).

amigos(1,[2,3]).
amigos(2,[1,4]).
amigos(3,[1]).
amigos(4,[2]).


amigo(A,B):- pessoa(Id1, A,_,_) , pessoa(Id2, B, _,_) , amigos(Id1, L1), member(Id2, L1).
em_comum(A,B,L):- pessoa(Id1, A,_,_) , pessoa(Id2, B, _,_), amigos(Id1, L1), amigos(Id2, L2), findall(X,(member(X,L1),member(X,L2)),L).



%%%sentence("quantos amigos do zé têm mais de 21 anos").
%%%sentence("quais são os amigos em comum do zé e da rita").
%%%sentence("quais são os amigos do zé").

%%sentence("quantos amigos tem a rita").

%%sentence("o joão é amigo do zé").
%%sentence("a rita é amiga da ana").
%%sentence("o zé é amigo da rita").

%%sentence("a ana e a rita são amigas").


parse_sentence(Text,List):- 
text_to_string(Text,String), 
string_codes(String,Codes),
split_string(String, " ", "\s\t\n" , List ).

getGender(f,f,f).
getGender(m,_,m).
getGender(_,m,m).

sentence_to_codes([], Res,Res).
sentence_to_codes([H|T], Temp, Res):- 
					string_codes(H,Code),
					append(Temp,[Code],Temp2),
					sentence_to_codes(T,Temp2,Res).

compare_to_lex(Code,Word,Type,Gen,Num):-		
						lex(Word,Type,Gen,Num),
						text_to_string(Word,String),
						string_codes(String,Code).	


compare_to_lex(Code,Word,Meaning, Type,Gen,Num):-		
						lex(Word,Meaning,Type,Gen,Num),
						text_to_string(Word,String),
						string_codes(String,Code).														


  




