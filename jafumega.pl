%%AfroSamurai 1800


read_routine(L):-
read_line_to_codes(user_input, Input),
atom_codes(Atom, Input),
atomic_list_concat(L, ' ', Atom),
print(L).

%%usefull
%%portray_text(+Boolean) 
%%

%%GHost in the shell %%%%1830
concorda_frase(L):-
s(A,B,C,D,L,[]),write(L),contextualizer(C,[],C1),contextualizer(D,[],D1),append(C1,D1,Seed),
tree(Seed,Tree),write(Ret),write('concordo');write('discordo').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Context analizer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getAnswer('universidade',Tree,Answer):-[ ['pais',X],['cidade',X], ['tipo', T] , ['universidade', Answer, X,T] ,['faculdade', Answer,SF,AF] ,['curso', SF, AC,SC] ] .

%%getAnswer('faculdade',Tree,Answer):-

%%getAnswer('curso',Tree,Answer):-


getTreeValues(Cidade,Tipo,AreaF,AreaC)


contextualizer([],Temp,PredList):-append([],Temp,PredList).
contextualizer([H|T],Temp,PredList):-lexico(H,H1,'n',_),append(Temp,[H-H1],Temp2),contextualizer(T,Temp2,PredList).


tree(Lista,Finaltree):-partialtree(Lista,Leaf,Branch), tree-aux(Leaf,Branch,[],Finaltree).

tree-aux(Leaf,[],Temp,List):- append(Temp,[],List).
 tree-aux(Leaf,[Br|Tr],Temp,List):-addleaftobranch(Br,Leaf,[],FullBranch),append(FullBranch,Temp,Temp2 ),tree-aux(Leaf,Tr,Temp2,List).


partialtree(Lista,Leaf,Branch):-getbranch(Lista,[],Branch),getleaf(Lista,[],Leaf).

getbranch([],List1,List2):-append(List1,[],List2).
getbranch([A-B|T],List1,List2):-branch(B,N),append([B-N],[],NextL1),getbranch(T,NextL1,List2).
getbranch([A-B|T],List1,List2):-leaf(B,_),getbranch(T,List1,List2).

branch('curso',1).
branch('faculdade',2).
branch('universidade',3).
branch('cidade',4).
branch('pais',5).

getleaf([],List1,List2):-append(List1,[],List2).
getleaf([A-B|T],List1,List2):-leaf(B,N),append(List1,[A],NextL1),getleaf(T,NextL1,List2).
getleaf([A-B|T],List1,List2):-branch(B,_),getleaf(T,List1,List2).

leaf('sigla',1).
leaf('area',2).

addleaftobranch(B-N,[],Temp,FullBranch):-append([B],Temp,FullBranch).
addleaftobranch(B-N,[H|T],Temp,FullBranch):- Pred =.. [B,H],Pred,append([H],Temp,Temp2),addleaftobranch(B-N,T,Temp2,FullBranch).

testtree:-tree(['mieic'-'sigla' ,'curso'-'curso', 'informatica'-'area'],Lista),write(Lista).
testtree2:-tree(['feup'-'sigla' ,'faculdade'-'faculdade', 'engenharia'-'area'],Lista),write(Lista).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAMATICA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s('declarativo','pertencer',Suj,_) --> np_(TempSuj,Suj,Q1).
s('declarativo',Acc,Suj2,Obj) --> np_(Suj,Suj2,Q1), vp(Acc,Obj,Q1).
s(Tipo,Acc,Obj,Att) --> is(Tipo,Att,Q),vp(Acc,Obj,Q1),['?'].
np(QQ,Q) -->  det(S,Q), n(QQ,S,Q).
np(QQ,Q) -->  n(QQ,_,Q).

np_(Lista,Lista2,Q1)-->np(Obj,Q1),{append([Obj],Lista,ListaRec)}  
     , np_(ListaRec,Lista2,_) | [],{append(Lista,[],Lista2),!}.


is(Tipo,_,Q)-->pro(Tipo,Q).
is(Tipo,Att,Q) -->pro(Tipo,Q),qnp(Att,Q).
is(Tipo,Att,Q)-->pro(Tipo,Q),vp('ser',Att,Q).

vp(Acc,Obj,C) --> v(Acc,C), np_(VarObj,Obj,C1).
vp(Acc,Obj,C) --> v(Acc,C);[] , np_(VarObj,Obj,C1).
vp(Acc,Obj,C) --> v(Acc,C);pro(_,_) , np_(VarObj,Obj,C1).

qnp(Att,Q) --> np_(At,Att,Q),pro(_,_).
qnp(Att,Q) --> np_(At,Att,Q),pro('atributivo',_).
qnp(Att,Q) --> np_(At,Att,Q).


det(S,Q) --> [Word],{lexico(Word,'det',S-Q)}.
n(Word,S,Q) --> [Word],{lexico(Word,Predicalizavel,'n',S-Q)}.
v(Accao,Q) --> [Word],{lexico(Word,Accao,'v',Q)}.
pro(Tipo,Q) --> [Word],{lexico(Word,'pro',Tipo,Q)}.



%%%%%%%%%%%%%%%%%%%%%%Acessos á Base De Conhecimento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declarativo(Acc,Suj,Obj):- Pred =.. [Acc,Suj,Obj],Pred.

%%designativo(Pred,Ret):-  .

%%quantificativo()
 lecionar(Nome_professor,Nome_cadeira):-professor(Nome_professor),cadeira(Nome_cadeira,_,_,ListaProf),member(Nome_professor,Listaprof).
 pertencer(Universidade,Faculdade):- ( Uni =..Universidade, Uni ).
%%pertencer(Universidade,Curso):- 
%%pertencer(Faculdade,Curso):-
%%pertencer(Curso,Cadeira):-

ser([A],[B]):-  lexico(A,C,'n',_), Pred =.. [C,B],Pred  ; lexico(B,C,'n',_), Pred =.. [C,A],Pred.


 %%%%%%%%%%%%%%%%%%%%%%Teste á base de conhecimento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tbc1:-concorda_frase([ 'a' ,'universidade', 'do' , 'Porto','tem','faculdade' , 'de', 'engenharia' ]).
tbc2:-concorda_frase([ 'a' ,'universidade', 'do' , 'Porto'] ).
tbc4:-concorda_frase([  'a', 'feup', 'e', 'faculdade', 'de', 'engenharia' ]).
tbc5:-concorda_frase(['quais', 'sao', 'as','universidades' , 'do', 'pais','?']).
tbc6:-concorda_frase(['o','porto','e','cidade']).
tbc7:-concorda_frase(['a','feup','e','faculdade']).
tbc8:-concorda_frase(['o' , 'mieic', 'e', 'curso']).
tbc9:-concorda_frase(['o' , 'mieic', 'e', 'curso', 'de','informatica']).
tbc10:-concorda_frase(['quais' , 'os', 'cursos', 'da','feup', '?']).

%%%%%%%%%%%%%%%%%%%%%%Base De Conhecimento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%aluno(Nome,ListaCadeiras,Curso,Universidade):-
aluno('aluno',[],_).
aluno('alunos',[],_).
aluno('ze',['plog','aiad'],'Informatica','Porto').

professor(['professor']).
professor(['Henrique']).
professor(['Ana']).

%%cadeira(Sigla,ListaAlunosInscritos,creditos,Listaprof)
cadeira('iart',['ze'],6,['Henrique','Ana']).

%%curso(A,NomeCurso,Sigla,ListaCadeiras,vagasPreenchidas,mediaUltimo).

curso(A):-curso(_,A,_);curso(_,_,A);curso(A,_,_).
curso('feup' ,'informatica','mieic').
curso('fadeup','desporto','desp').

area('informatica').
area('engenharia').

%%faculdade(Uni,Sigla,ListaCursos,Polo).
faculdade(A):-faculdade(A,_,_); faculdade(_,A,_);faculdade(_,_,B),member(A,B).
faculdade('up' ,'feup','engenharia').

%%universidade(Sigla , ListaFaculdades , Cidade, Tipo)
universidade(A):-universidade(A,_,_,_);universidade(_,L,_,_),member(A,L).

universidade('up','porto','Publica').
universidade('ul','lisboa','Publica').
universidade('um','braga','Publica').
universidade('um','guimaraes','Publica').
universidade('upt','porto','Privada').

sigla('feup').
sigla('mieic').

tipo('privada').
tipo('publica').

cidade('lisboa').
cidade('porto').
cidade('coimbra').

pais(X):-cidade(X).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lexico%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%lexico
%%% determinantes
lexico('o','det',m-s).
lexico('a','det',f-s).
lexico('os','det',m-p).
lexico('as','det',f-p).

lexico('de','det',_-s).
lexico('da','det',f-s).
lexico('do','det',m-s).


%%%nomes

lexico('Ze','aluno','n',m-s).
lexico('Henrique','professor','n',m-s).
lexico('Ana','professor','n',f-s).

lexico('cidade','cidade','n',f-s).


lexico('informatica', 'area' , 'n',_-s).
lexico('engenharia','area' ,'n',f-s).
lexico('feup','sigla' ,'n',f-s).
lexico('isep','sigla' ,'n',f-s).

lexico('pais','pais','n',m-s).
lexico('universidade','universidade' ,'n',f-s).
lexico('universidades','universidade','n',f-p).
lexico('faculdade','faculdade','n',f-s).
lexico('faculdades','faculdade','n',f-p).
lexico('curso','curso','n',m-s).
lexico('cursos','curso','n',m-p).
lexico('mieic','sigla','n',m-s).
lexico('professor','professor' ,'n',m-s).
lexico('professores','professor' ,'n',m-p).
lexico('aluno','aluno' ,'n',m-s).
lexico('alunos','aluno' ,'n',m-p).


lexico('cadeira','cadeira','n',f-s).
lexico('cadeiras','cadeira','n',f-p).
lexico('iart','sigla','n',m-s).
lexico('aiad','sigla','n',m-s).


%%verbos
lexico('frequenta','frequentar','v',s).
lexico('frequentam','frequentar','v',p).
lexico('leciona','lecionar','v',s).
lexico('lecionam','lecionar','v',p).
lexico('pertence','pertencer','v',s).
lexico('tem','pertencer','v',s).
lexico('tem','pertencer','v',p).
lexico('sao','ser','v',p).
lexico('e','ser','v',s).

%%pronomes
lexico('quantas','pro','quantificativo',p).
lexico('quanto','pro','quantificativo',s).
lexico('quais','pro','designativo',p).
lexico('que','pro','relativo',_).
lexico('com','pro','atributivo',_).

lexico('porto', 'cidade' ,'n',m-s).
lexico('Lisboa','n',f-s).
lexico('Coimbra','n',f-s).


%%%%%%%%%%%%%%%%%%%39 grupo%%%%%%%%%%%%%%%%testes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%testa concordacia de genero entre det e nome%%%
teste1:-concorda_frase(['o' ,'Henrique' ,'leciona' ,'iart']).
teste2:- concorda_frase(['o' ,'Ana' ,'leciona' ,'iart']). 

%%%%testa concordacia semantica entre sujeito e verbo%%%
teste3:- concorda_frase(['o' ,'Ze' ,'frequenta' ,'iart']). 
teste4:- concorda_frase(['o' ,'Henrique' ,'frequenta' ,'iart']).

%%%%testa concordacia semantica entre verbo e complemento%%%
teste5:- concorda_frase(['o' ,'aluno' ,'frequenta' ,'o','cafe']). 
teste6:- concorda_frase(['o' ,'Henrique' ,'leciona' ,'iart']).

%%%%testa concordacia em numero entre determinante e nome%%%
teste7:- concorda_frase(['os' ,'alunos' ,'frequentam' ,'iart']). 
teste8:- concorda_frase(['os' ,'Ze' ,'frequenta' ,'iart']).  


%%%%testa concordacia em numero entre sujeito e verbo%%%
teste9:- concorda_frase(['os' ,'alunos' ,'frequenta' ,'iart']). 
teste10:- concorda_frase(['os' ,'alunos' ,'frequentam' ,'iart']).

teste11:- concorda_frase(['os' ,'alunos' ,'frequentam' ,'faculdade','de','Engenharia']).
teste12:- concorda_frase(['Universidade','do','Porto','frequenta' ,'faculdade','de','Engenharia']).
teste13:- concorda_frase(['faculdade', 'de', 'Engenharia' , 'da' ,'Universidade','do','Porto']).
%%write(['os' ,'alunos' ,'frequentam','faculdade','de','Engenharia']).

%%teste14:- s3('faculdade','de','Engenharia','da','Universidade').

teste15:- concorda_frase( ['quais' , 'as', 'faculdades', 'de', 'Engenharia', '?' ] ).
teste16:- concorda_frase( ['quais' , 'as', 'faculdades', 'que', 'tem', 'o', 'curso', 'de' , 'Informatica', '?'] ).
teste17:- concorda_frase( ['quantas' ,'sao', 'as', 'faculdades', 'com', 'o', 'curso', 'de' , 'Informatica', '?'] ).
teste18:- concorda_frase( ['quantas' , 'as', 'faculdades', 'que', 'tem', 'curso', 'de' , 'Informatica', '?'] ).






%%%%GIGGER STEREOGRAMS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



main3:-
read_routine(A),
write('parrot'),write(B).
