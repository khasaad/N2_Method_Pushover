%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Information organization output of andilwall software dependent on moving home structures due to earthquakes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
  for p_i = 1:6  %numero configurazione strutturale

% get main directory (Projects directory)
pathFolder=uigetdir();

% get list of subfolders 24cm 30cm 35cm 40cm
d = dir(pathFolder);
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

% prompt user to select which subfolders to process
[s,v] = listdlg('PromptString','Select folders:',...
    'SelectionMode','multiple',...
    'ListString',nameFolds);

% use only those directories
directories=char(nameFolds(s));

for i= 1:size(directories,1)
piano = strtrim([pathFolder,filesep,strtrim(directories(i,:)),...
                ]);
            
% get list of subfolders piano1 piano2 piano3 piano4
d = dir(piano);
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];        

% use only those directories
directories1=char(nameFolds(:));
end
p = size(directories,1);

for w =1:p
for h= 1:size(directories1,1)  
piano_i = strtrim([pathFolder,filesep,strtrim(directories(w,:)),... 
    filesep,strtrim(directories1(h,:)),...
    ]);

% get list of subfolders con cordolo - senza cordolo 

d = dir(piano_i);
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

% % prompt user to select which subfolders to process
% [s,v] = listdlg('PromptString','Select folders:',...
%     'SelectionMode','multiple',...
%     'ListString',nameFolds);

% use only those directories
directories2=char(nameFolds(:));

con_cordolo = strtrim([pathFolder,filesep,strtrim(directories(w,:)),... 
    filesep,strtrim(directories1(h,:)),filesep,directories2(1,:),...
    ]);
            
senza_cordolo =strtrim([pathFolder,filesep,strtrim(directories(w,:)),... 
    filesep,strtrim(directories1(h,:)),filesep,directories2(2,:),...
    ]);

e_xcel =strtrim([pathFolder,filesep,strtrim(directories(w,:)),...
     filesep,strtrim(directories1(h,:))]);
 
 
%%%%%%%              CON CORDOLO             %%%%%%%%
cd(con_cordolo);           

list = dir;
list =list([list.isdir]);
list =list(~ismember({list.name},{'.' '..'}));

l = length(list); 
oldfolder = cd(list(1).name);

for k = 1:16
      m11    =  load(['PIANO1M_' num2str(k) '.dan_1']);
      d11    = length(m11);
      d22(k) =  d11;
      dd     = max(d22); 
end

cd(oldfolder); 
oldfolder = cd(list(2).name);

for k = 1:16
      m1    =  load(['PIANO1T_' num2str(k) '.dan_1']);
      d1    = length(m1);
      d2(k) =  d1;
      d     = max(d2);
end

z = max(d,dd);

cd(oldfolder); 
oldfolder = cd(list(1).name);

m11 =[];
mm =[];

 for  i = 1:16
      m11 = [ load(['PIANO1M_' num2str(i) '.dan_1'])];     
      am11 = [m11;zeros(((z-d22(i))),1)];     
      mm(:,i) = am11;    
 end

cd(oldfolder); 
oldfolder = cd(list(2).name);

  m =[];
  m1=[];
 
 for  i = 1:16
      m1 = [ load(['PIANO1T_' num2str(i) '.dan_1'])];
      am1 = [m1;zeros(((z-d2(i))),1)];
      m(:,i) = am1;
 end

 
f = [m mm];

cd(oldfolder); 
oldfolder = cd(list(2).name);

 aa1 =[];
 b =[];
 
 for i = 1:8
      a1 =  importdata(['PIANO1T_' num2str(i) '.f_d']);    
      aa1 = a1.data(:,3); 
      c_1 = length(aa1);
      e_1(i) =  c_1;
      b = max(e_1);     
 end

  bb = [];
  aa2=[];
  
  for i = 9:16
      a2 =  importdata(['PIANO1T_' num2str(i) '.f_d']);    
      aa2 = a2.data(:,4); 
      c_2 = length(aa2);
      ee(i) =  c_2;
      bb = max(ee);  
  end

x = max(b,bb);

cd(oldfolder); 
oldfolder = cd(list(1).name);

a1 =[];
b1 =[];
aa1 =[];
 for i = 1:8
      a1 =  importdata(['PIANO1M_' num2str(i) '.f_d']);    
      aa1 = a1.data(:,3); 
      c_3 = length(aa1);
      e1(i) =  c_3;
      b1 = max(e1);  
 end
 
 bb1 = [];
 a2 =[];
 aa2=[];
 
  for i = 9:16
      a2 =  importdata(['PIANO1M_' num2str(i) '.f_d']);    
      aa2 = a2.data(:,4); 
      c_4 = length(aa2);
      ee1(i) =  c_4;
      bb1 = max(ee1);  
  end

 xx = max(b1,bb1);
 xxx = max(x,xx);
 
cd(oldfolder);
oldfolder = cd(list(2).name);

n2 =[];
n0 =[];
n11 =[];

 for  i = 1:8
      n1 = importdata(['PIANO1T_' num2str(i) '.f_d']);
      n2 = [n1.data(:,3)];
      n11 = [n2;zeros(((xxx-e_1(i))),1)];
      n0(:,i) = n11; 
 end
 
 n4 =[];
 nn0 =[];
 n33=[];
 n3=[];
 for  i = 9:16
      n3 = importdata(['PIANO1T_' num2str(i) '.f_d']);
      n4 = [n3.data(:,4)];
      n33 = [n4;zeros(((xxx-ee(i))),1)];
      nn0(:,i) = n33;
 end
 
an0 =[n0 nn0(:,9:16)];

cd(oldfolder); 
oldfolder = cd(list(1).name);

n2 =[];
n01 = [];
n1=[];
 for  i = 1:8
      
      n1 = importdata(['PIANO1M_' num2str(i) '.f_d']);
      n2 = [n1.data(:,3)];
      n11 = [n2;zeros(((xxx-e1(i))),1)];
      n01(:,i) = n11;
  
 end
 
 n4 =[];
 n02 = [];
 
 for  i = 9:16
      
      n3 = importdata(['PIANO1M_' num2str(i) '.f_d']);
      n4 = [n3.data(:,4)];
      n33 = [n4;zeros(((xxx-ee1(i))),1)];
      n02(:,i) = n33;
  
 end 
n11 =[n01 n02(:,9:16)];

% il taglio
ff = [an0 n11]; 

cd(oldfolder); 
oldfolder = cd(list(1).name);

nlem = importdata('PIANO1M_1.sam');
nelem= nlem.data(1,2);

cd(oldfolder);

% trovare il passo

 for i =1:32
a   = floor(f(:,i)/1000);
b   = rem(a,10);
c   = floor(f(:,i)/100);
ddd = rem(c,10);
e   = zeros(z,1);

for j = 1:length(f(:,i))
    if mod(b(j)-1,5)>0
        e(j,i)=1;
    elseif  mod(ddd(j)-1,5)>0
       e(j,i) = 2;
    end
end

m =[];
p = 0;
qq = [];

for k = 1:length(f(:,i))
          if e(k,i)==1 || e(k,i)==2
           p=k;       
          break         
          end      
end
      m = [m;p];     
      passo_con(i) = floor(m/nelem+1);     
      q = ff(:,i);   
      qq = [ qq abs(q(passo_con(i))/1000) ];      
      qqq(i) = qq;      
 end 
 
 A_passo_con_T = passo_con(1:16)';
 A_passo_con_M = passo_con(17:32)';
 A_G1T = qqq(1:16)';
 A_G1M = qqq(17:32)';
 
 %%%%%%%%%%%%%%%%      SENZA CORDOLO   %%%%%%%%%%%%%%
 
cd(senza_cordolo);           

list = dir;
list =list([list.isdir]);
list =list(~ismember({list.name},{'.' '..'}));

l = length(list); 
oldfolder = cd(list(1).name);

for k = 1:16
      m11_4    =  load(['PIANO1MS_' num2str(k) '.dan_1']);
      d11_4    = length(m11_4);
      d22_4(k) =  d11_4;
      dd_4    = max(d22_4); 
end

cd(oldfolder); 
oldfolder = cd(list(2).name);

for k = 1:16
      m1_4    =  load(['PIANO1TS_' num2str(k) '.dan_1']);
      d1_4    = length(m1_4);
      d2_4(k) =  d1_4;
      d_4    = max(d2_4);
end

z_4 = max(d_4,dd_4);

cd(oldfolder); 
oldfolder = cd(list(1).name);

m11_4 =[];
mm_4 =[];

 for  i = 1:16
      m11_4 = [ load(['PIANO1MS_' num2str(i) '.dan_1'])];     
      am11_4 = [m11_4;zeros(((z_4-d22_4(i))),1)];     
      mm_4(:,i) = am11_4;    
 end

cd(oldfolder); 
oldfolder = cd(list(2).name);

 m_4 =[];
 m1_4=[];
 
 for  i = 1:16
      m1_4 = [ load(['PIANO1TS_' num2str(i) '.dan_1'])];
      am1_4 = [m1_4;zeros(((z_4-d2_4(i))),1)];
      m_4(:,i) = am1_4;
 end

 
f_4 = [m_4 mm_4];

cd(oldfolder); 
oldfolder = cd(list(2).name);

 aa1_4 =[];
 aa2_4=[];
 b_4 =[];
 bb_4 = [];
 for i = 1:8
      a1_4 =  importdata(['PIANO1TS_' num2str(i) '.f_d']);    
      aa1_4 = a1_4.data(:,3); 
      c_4 = length(aa1_4);
      E_4(i) =  c_4;
      b_4 = max(E_4);     
 end

  for i = 9:16
      a2_4 =  importdata(['PIANO1TS_' num2str(i) '.f_d']);    
      aa2_4 = a2_4.data(:,4); 
      c_4 = length(aa2_4);
      EE_4(i) =  c_4;
      bb_4 = max(EE_4);  
  end

x_4 = max(b_4,bb_4);


cd(oldfolder); 
oldfolder = cd(list(1).name);

 a1_4 =[];
 b1_4 =[];
 bb1_4 = [];
 for i = 1:8
      a1_4 =  importdata(['PIANO1MS_' num2str(i) '.f_d']);    
      aa1_4 = a1_4.data(:,3); 
      c_4 = length(aa1_4);
      E1_4(i) =  c_4;
      b1_4 = max(E1_4);      
 end

for i = 9:16
      a2_4 =  importdata(['PIANO1MS_' num2str(i) '.f_d']);    
      aa2_4 = a2_4.data(:,4); 
      c_4 = length(aa2_4);
      EE1_4(i) =  c_4;
      bb1_4 = max(EE1_4);  
end

 xx_4 = max(b1_4,bb1_4);
 xxx_4 = max(x_4,xx_4);
 
cd(oldfolder);
oldfolder = cd(list(2).name);

n2_4 =[];
n0_4 =[];
 
for  i = 1:8
      n1_4 = importdata(['PIANO1TS_' num2str(i) '.f_d']);
      n2_4 = [n1_4.data(:,3)];
      n11_4 = [n2_4;zeros(((xxx_4-E_4(i))),1)];
      n0_4(:,i) = n11_4; 
end
 
 n4_4 =[];
 nn0_4 =[];
 
for  i = 9:16
      n3_4 = importdata(['PIANO1TS_' num2str(i) '.f_d']);
      n4_4 = [n3_4.data(:,4)];
      n33_4 = [n4_4;zeros(((xxx_4-EE_4(i))),1)];
      nn0_4(:,i) = n33_4;
end
 
an0_4 =[n0_4 nn0_4(:,9:16)];

cd(oldfolder); 
oldfolder = cd(list(1).name);

n2_4 =[];
n01_4 = [];

for  i = 1:8
      
      n1_4 = importdata(['PIANO1MS_' num2str(i) '.f_d']);
      n2_4 = [n1_4.data(:,3)];
      n11_4 = [n2_4;zeros(((xxx_4-E1_4(i))),1)];
      n01_4(:,i) = n11_4; 
 end
 
 n4_4 =[];
 n02_4 = [];
 for  i = 9:16
      
      n3_4 = importdata(['PIANO1MS_' num2str(i) '.f_d']);
      n4_4 = [n3_4.data(:,4)];
      n33_4 = [n4_4;zeros(((xxx_4-EE1_4(i))),1)];
      n02_4(:,i) = n33_4;
  
 end 
 
n11_4 =[n01_4 n02_4(:,9:16)];

% il taglio
ff_4 = [an0_4 n11_4]; 

cd(oldfolder); 
oldfolder = cd(list(1).name);

nlem = importdata('PIANO1MS_1.sam');
nelem= nlem.data(1,2);

cd(oldfolder);

% trovare il passo

 for i =1:32
a_4  = floor(f_4(:,i)/1000);
b_4   = rem(a_4,10);
c_4  = floor(f_4(:,i)/100);
ddd_4 = rem(c_4,10);
e_4   = zeros(z_4,1);

for j = 1:length(f_4(:,i))
    if mod(b_4(j)-1,5)>0
        e_4(j,i)=1;
    elseif  mod(ddd_4(j)-1,5)>0
       e_4(j,i) = 2;
        
    end
end

m_4 =[];
p_4 = 0;
qq_4 = [];

for k = 1:length(f_4(:,i))
          if e_4(k,i)==1 || e_4(k,i)==2
           p_4=k;       
          break         
          end      
end
      m_4 = [m_4;p_4];     
      passo_senza(i) = floor(m_4/nelem+1);     
      q_4 = ff_4(:,i);   
      qq_4 = [ qq_4 abs(q_4(passo_senza(i))/1000) ];      
      qqq_4(i) = qq_4;      
 end
 
B_passo_senza_TS = passo_senza(1:16)';
B_passo_senza_MS = passo_senza(17:32)';
 
B_G1TS = qqq_4(1:16)';
B_G1MS = qqq_4(17:32)';
 
ALFA =[];
ALFA = [A_G1T,A_passo_con_T,A_G1M,A_passo_con_M,B_G1TS,B_passo_senza_TS,B_G1MS,B_passo_senza_MS];
 
cd(e_xcel);

asnl = xlsread('a.xlsx');
fy_t = asnl(1:16,17);
fy_m = asnl(1:16,38);

fy_st = asnl(19:34,17);
fy_sm = asnl(19:34,38);

alfa_c = [fy_t./ALFA(:,1);fy_m./ALFA(:,3)];
alfa_s = [fy_st./ALFA(:,5);fy_sm./ALFA(:,7)];

d_slv_t = asnl(1:16,5);
d_y_t = asnl(1:16,16);

d_slv_m = asnl(1:16,26);
d_y_m = asnl(1:16,37);

d_slv_st = asnl(19:34,5);
d_y_st = asnl(19:34,16);

d_slv_sm = asnl(19:34,26);
d_y_sm = asnl(19:34,37);

dut_c = [d_slv_t./d_y_t;d_slv_m./d_y_m];
dut_s = [d_slv_st./d_y_st;d_slv_sm./d_y_sm];

type1 = [1.00	0.15	0.40	2.00
1.30	0.15	0.50	2.00
1.15	0.20	0.60	2.00
1.35	0.20	0.80	2.00
1.40	0.15	0.50	2.00];

type2 = [1.00	0.05	0.25	1.20
1.35	0.05	0.25	1.20
1.50	0.10	0.25	1.20
1.80	0.10	0.30	1.20
1.60	0.05	0.25	1.20];

type =[type1;type2];

t_c   = [asnl(1:16,15);asnl(1:16,36)];
t_s   = [asnl(19:34,15);asnl(19:34,36)]; 

d_slv_c   =[d_slv_t/100;d_slv_m/100];
d_slv_s   =[d_slv_st/100;d_slv_sm/100];

m_c   = [asnl(1:16,13);asnl(1:16,34)];
m_s   = [asnl(19:34,13);asnl(19:34,34)];

gamma_c   = [asnl(1:16,12);asnl(1:16,33)];
gamma_s   = [asnl(19:34,12);asnl(19:34,33)];

fy_c      = [fy_t;fy_m];
fy_s      = [fy_st;fy_sm];

smorz = 5;
c_s = max((10/(5+smorz))^0.5,0.55);
% % % % % % % % % Se/ag con cordolo% % % % % % % % 
for i=1:size(t_c)
    for j =1:size(type,1)  
    
if     t_c(i)>=0 & t_c(i)<=type(j,2)
        s1 = type(j,1)*(1+(t_c(i)/type(j,2))*(c_s*2.5-1));
elseif t_c(i)>=type(j,2) & t_c(i)<=type(j,3)
        s1 = type(j,1)*c_s*2.5;
elseif t_c(i)>=type(j,3) & t_c(i)<=type(j,4)
        s1 = type(j,1)*c_s*2.5*(type(j,3)/t_c(i));
elseif t_c(i)>=type(j,4) & t_c(i)<=4
        s1 = type(j,1)*c_s*2.5*(type(j,3)*type(j,4)/(t_c(i)^2));
end
        s2=[];
        s2 =[s2 s1];
        s(j,i) = s2;
    
    end
end
% % % % % % % % % Se/ag senza cordolo% % % % % % % % 
for i=1:size(t_s)
    for j =1:size(type,1)  
    
if     t_s(i)>=0 & t_s(i)<=type(j,2)
        s1 = type(j,1)*(1+(t_s(i)/type(j,2))*(c_s*2.5-1));
elseif t_s(i)>=type(j,2) & t_s(i)<=type(j,3)
        s1 = type(j,1)*c_s*2.5;
elseif t_s(i)>=type(j,3) & t_s(i)<=type(j,4)
        s1 = type(j,1)*c_s*2.5*(type(j,3)/t_s(i));
elseif t_s(i)>=type(j,4) & t_s(i)<=4
        s1 = type(j,1)*c_s*2.5*(type(j,3)*type(j,4)/(t_s(i)^2));
end
        s2=[];
        s2 =[s2 s1];
        ss(j,i) = s2;   
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% % % % % % % % % ag|dmax con cordolo% % % % % % % % 
Ag1=[0:0.001:20]';
p_c=1;
for i = 1:size(t_c)
    for j = 1:size(type,1) 
        
%         if t_c(i)>=type(j,3)
%             
%             ag1 = ((d_slv_c(i)/gamma_c(i))*(2*pi/t_c(i))^2)/(9.81*s(j,i));
%         else
%             
            for k = 1:size(Ag1)
    
               x_c =abs((((t_c(i)/(2*pi))^2)*(fy_c(i)/gamma_c(i))/m_c(i))*(((((s(j,i)*Ag1(k)*m_c(i)/(fy_c(i)/gamma_c(i)))-1)^2.1)/((t_c(i)/0.03+0.2)*((t_c(i)/type(j,3))^2.3)))+s(j,i)*Ag1(k)*m_c(i)/(fy_c(i)/gamma_c(i)))-d_slv_c(i)/gamma_c(i));
          
               if x_c <=0.0001
                   
                p_c = k;
                
                break 
               
               end 
 
            end
       
              ag1 = Ag1(p_c)/9.81;
  
             ag1 = min(((d_slv_c(i)/gamma_c(i))*(2*pi/t_c(i))^2)/(9.81*s(j,i)),ag1);
    
%          end
         
        ag2 =[];
        ag2 =[ag2 ag1];
        ag(j,i) = ag2;
    end
    end



% % % % % % % % % ag|dmax senza cordolo% % % % % % % % 
p_s=1;
for i = 1:size(t_s)
    for j = 1:size(type,1)
%         if t_s(i)>=type(j,3)
%             ag1 = ((d_slv_s(i)/gamma_s(i))*(2*pi/t_s(i))^2)/(9.81*ss(j,i));
%          else
%             
           for k = 1:size(Ag1)
              x_s = abs((((t_s(i)/(2*pi))^2)*(fy_s(i)/gamma_s(i))/m_s(i))*(((((ss(j,i)*Ag1(k)*m_s(i)/(fy_s(i)/gamma_s(i)))-1)^2.1)/((t_s(i)/0.03+0.2)*((t_s(i)/type(j,3))^2.3)))+ss(j,i)*Ag1(k)*m_s(i)/(fy_s(i)/gamma_s(i)))-d_slv_s(i)/gamma_s(i));
            if x_s <=0.0001
                
                p_s=k;
                break
             
             
             end
             
           end
        

            ag1 = Ag1(p_s)/9.81; 
            ag1 = min(((d_slv_s(i)/gamma_s(i))*(2*pi/t_s(i))^2)/(9.81*ss(j,i)),ag1);
                                   
%         end   
                        
        ag2 =[];
        ag2 =[ag2 ag1];
        aag(j,i) = ag2;
    end
end

% % % % % % % % % q* con cordolo % % % % % % % %

r_c=[0:0.001:800]';
p_c=1;
for i = 1:size(t_c)
    for j = 1:size(type,1) 
        
%         if t_c(i)>=0.5
%             r_c1 = ag(j,i)*s(j,i)*9.81*m_c(i)/(fy_c(i)/gamma_c(i)); 
%         else
%             
            for k = 1:size(r_c)
                
                 x_cc =abs((((((r_c(k))-1)^2.1)/((t_c(i)/0.055+0.7)*((t_c(i)/type(j,3))^2.3)))+r_c(k))-dut_c(i));
    
%                x_cc =abs((((((r_c(k))-1)^2.1)/((t_c(i)/0.03+0.2)*((t_c(i)/type(j,3))^2.3)))+r_c(k))-dut_c(i));
          
               if x_cc <=0.01
                   
                p_c = k;
                
                break 
               
               end 
 
            end
       
             r_c1 = r_c(p_c);
    
%          end
         
        r_c2 =[];
        r_c2 =[r_c2 r_c1];
        r_cc(j,i) = r_c2;
     end
end

        
% % % % % % % % % q* senza cordolo % % % % % % % %

p_s=1;
for i = 1:size(t_s)
    for j = 1:size(type,1) 
        
%         if t_s(i)>=0.5
%             r_s1 = aag(j,i)*ss(j,i)*9.81*m_s(i)/(fy_s(i)/gamma_s(i));
%         else
%             
            for k = 1:size(r_c)
                x_ss =abs((((((r_c(k))-1)^2.1)/((t_s(i)/0.055+0.7)*((t_s(i)/type(j,3))^2.3)))+r_c(k))-dut_s(i));
    
%                x_ss =abs((((((r_c(k))-1)^2.1)/((t_s(i)/0.03+0.2)*((t_s(i)/type(j,3))^2.3)))+r_c(k))-dut_s(i));
          
               if x_ss <=0.01
                   
                p_s = k;
                
                break 
               
               end 
 
            end
       
             r_s1 = r_c(p_s);
    
%          end
         
        r_s2 =[];
        r_s2 =[r_s2 r_s1];
        r_ss(j,i) = r_s2;
end
end


% % % % % % % % % q con cordolo % % % % % % % %
for i = 1:size(alfa_c)
    for j = 1:size(type,1)
        Q1 = r_cc(j,i)*alfa_c(i);
        Q2 = [];
        Q2 = [Q2 Q1];
        Q_1(j,i)=Q2;
    end
end

% % % % % % % % % q senza cordolo % % % % % % % %
for i = 1:size(alfa_s)
    for j = 1:size(type,1)
        Q1 = r_ss(j,i)*alfa_s(i);
        Q2 = [];
        Q2 = [Q2 Q1];
        Q_2(j,i)=Q2;
    end
end
% % % % % % % % % PGA con cordolo % % % % % % % %

for i = 1:size(ag,2)
    for j = 1:size(type,1)
        if r_cc(j,i)>3
           ag(j,i) = 3*(fy_c(i)/gamma_c(i))/(m_c(i)*9.81*s(j,i));
       end
        PGA1 = type(j,1)*ag(j,i);
        PGA2 = [];
        PGA2 = [PGA2 PGA1];
        PGA(j,i) = PGA2;
    end
end

% % % % % % % % % PGA SENZA CORDOLO% % % % % % % %
for i = 1:size(aag,2)
    for j = 1:size(type,1)
        if r_ss(j,i)>3
           aag(j,i) = 3*(fy_s(i)/gamma_s(i))/(m_s(i)*9.81*ss(j,i));
       end
        PGA1 = type(j,1)*aag(j,i);
        PGA2 = [];
        PGA2 = [PGA2 PGA1];
        pGA(j,i) = PGA2;
    end
end
m = 31*(h-1)+h;
n = 31*(h-1)+h+31;
        
PGA_C_1 = [];
PGA_S_1 = [];
PGA_C1 = [PGA_C_1 PGA];
PGA_S1 = [PGA_S_1 pGA];
PGA_C([1:10],[m:n]) = PGA_C1;
PGA_S([1:10],[m:n]) = PGA_S1;

Q_C_1 =[];
Q_S_1 =[];
Q_C1 =[Q_C_1 Q_1];
Q_S1 =[Q_S_1 Q_2];
Q_C([1:10],[m:n]) =Q_C1;
Q_S([1:10],[m:n]) =Q_S1;

q_c_1 =[];
q_s_1 =[];
q_c1 =[q_c_1 r_cc];
q_s1 =[q_s_1 r_ss];
q_c([1:10],[m:n]) =q_c1;
q_s([1:10],[m:n]) =q_s1;

ag_c_1 =[];
ag_s_1 =[];
ag_c1 = [ag_c_1 ag];
ag_s1 = [ag_s_1 aag];
ag_c([1:10],[m:n])= ag_c1;
ag_s([1:10],[m:n])= ag_s1;

alf_c_1 =[];
alf_s_1 =[];
alf_c1 = [alf_c_1 alfa_c];
alf_s1 =[alf_s_1 alfa_s];
alf_c(:,h) = alf_c1;
alf_s(:,h) = alf_s1;

end

m = 127*(w-1)+w;
n = 127*(w-1)+w+127;
m_1 = 3*(w-1)+w;
n_1 = 3*(w-1)+w+3;

PGA_C_1 = [];
PGA_S_1 = [];
PGA_C1 = [PGA_C_1 PGA_C];
PGA_S1 = [PGA_S_1 PGA_S];
PGA_C_E([1:10],[m:n]) = PGA_C1;
PGA_S_E([1:10],[m:n]) = PGA_S1;

Q_C_1 =[];
Q_S_1 =[];
Q_C1 =[Q_C_1 Q_C];
Q_S1 =[Q_S_1 Q_S];
Q_C_E([1:10],[m:n]) =Q_C1;
Q_S_E([1:10],[m:n]) =Q_S1;

q_c_1 =[];
q_s_1 =[];
q_c1 =[q_c_1 q_c];
q_s1 =[q_s_1 q_s];
q_c_e([1:10],[m:n]) =q_c1;
q_s_e([1:10],[m:n]) =q_s1;

ag_c_1 =[];
ag_s_1 =[];
ag_c1 = [ag_c_1 ag_c];
ag_s1 = [ag_s_1 ag_s];
ag_c_e([1:10],[m:n])= ag_c1;
ag_s_e([1:10],[m:n])= ag_s1;

alf_c_1 =[];
alf_s_1 =[];
alf_c1 = [alf_c_1 alf_c];
alf_s1 =[alf_s_1 alf_s];
alf_c_e(:,[m_1:n_1]) = alf_c1;
alf_s_e(:,[m_1:n_1]) = alf_s1;

end

m = 9*(p_i-1)+p_i;
n = 9*(p_i-1)+p_i+9;
m_1 = 15*(p_i-1)+p_i;
n_1 = 15*(p_i-1)+p_i+15;

PGA_C_2 = [];
PGA_S_2 = [];
PGA_C2 = [PGA_C_2 PGA_C_E];
PGA_S2 = [PGA_S_2 PGA_S_E];
PGA_C_E1([m:n],:) = PGA_C2;
PGA_S_E1([m:n],:) = PGA_S2;

Q_C_2 =[];
Q_S_2 =[];
Q_C2 =[Q_C_2 Q_C_E];
Q_S2 =[Q_S_2 Q_S_E];
Q_C_E1([m:n],:) =Q_C2;
Q_S_E1([m:n],:) =Q_S2;

q_c_2 =[];
q_s_2 =[];
q_c2 =[q_c_2 q_c_e];
q_s2 =[q_s_2 q_s_e];
q_c_e1([m:n],:) =q_c2;
q_s_e1([m:n],:) =q_s2;

ag_c_2 =[];
ag_s_2 =[];
ag_c2 = [ag_c_2 ag_c_e];
ag_s2 = [ag_s_2 ag_s_e];
ag_c_e1([m:n],:)= ag_c2;
ag_s_e1([m:n],:)= ag_s2;

alf_c_2 =[];
alf_s_2 =[];
alf_c2 = [alf_c_2 alf_c_e];
alf_s2 = [alf_s_2 alf_s_e];
alf_c_e1(:,[m_1:n_1]) = alf_c2;
alf_s_e1(:,[m_1:n_1]) = alf_s2;

 end


     