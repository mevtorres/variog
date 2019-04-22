clear;
[filename1,filepath1]=uigetfile({'*.*','All Files'},...'Select Data File 1');
cd(filepath1);
BGDC=load(filename1);
filename2=strrep(filename1,'.','_');
x = BGDC(:,1);
y = BGDC(:,2);
z = BGDC(:,3);
DENSIDADE=2.100
hi=500
hinc=input('hinc=');
%hf=input('hf=');
hf=12000
tol=input('tol= lag ');
[L,M]=size(BGDC);
n=L;
ind=1;
for h=hi:hinc:hf;
s=0;
m=0;
j=1;
% Caulcula o valor do variograma para o "lag"h.
for j=1:n-1,
% Calcula vetorizado as dist^ancias entre os pontos e as
% respectivas diferncas entre as grandezas nestes pontos.
%a=[vj(j,3)-vj(j+1:n,3),((vj(j,1)-vj((j^+1):n,1)).^2+(vj(j,2)-vj((j+1):n,2)).^2).^0.5];
%modificada para varios bgs
a=[z(j,1)-z(j+1:n,1),((x(j)-x((j+1):n)).^2+(y(j)-y((j+1):n)).^2).^0.5];
% Encontra os índices "i"das componetes que estão
% dentro do "lag" tol, e soma os quadrados das
% componentes encontradas
i=find( a(:,2) <(h+tol) & a(:,2) > (h-tol));
s=sum((a(i,1)).^2)+s;
m=length(a(i,1)~=0)+m;
end
gama(ind,2)=s/m;
gama(ind,1)=h;
ind=ind+1;
end
LogR(:,1)=log(gama(:,1));
LogR(:,2)=log(gama(:,2));
%xlswrite(filename2,gama,dens_i);
D(dens_i-2,1)=3.0 - (lsqr(LogR(:,1),LogR(:,2))/2.0);
D(dens_i-2,2)=DENSIDADE;
DENSIDADE=DENSIDADE+0.025;
%xlswrite(filename2,D,1)

