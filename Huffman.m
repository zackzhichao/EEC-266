function [letterinfile,letterprob,letterlength,avelength]=Huffman(originaltext,D)
% Zhichao Qiu EEC 266 Project
letterprob=[];letterlength=[];
avelength=0;i=1;
letterinfile=unique(originaltext,'stable');
for a=1:length(letterinfile)
    letterprob(a)=length(strfind(originaltext,letterinfile(a)));
end
letterprob=letterprob/sum(letterprob);
c=letterprob;
lengthp=length(letterprob);
for a=1:lengthp
    digitn(a,1)="";
end
lengthc=length(c);
e=length(letterinfile)-1;
for a=1:e+1
    code(a,1)="";
end
if e==0
    code(1)='0';
else
    for f=1:ceil((e+1-D)/(D-1))+1
        if f==1
            h=rem(e+1-D,D-1);
            if h>0
                [B,I(i,:)]=mink(c,D-h-1);
                for a=1:h+1
                    code(I(i,a))=num2str(a-1);
                    c(I(i,a))=1+c(I(i,a));
                end
                c(lengthc+1)=sum(B);
                lengthc=length(c);
                for a=h+2:D
                    I(i,a)=I(i,h+1);
                end
                i=i+1;
            elseif h==0
                    [B,I(i,:)]=mink(c,D);
                    for a=1:D
                        code(I(i,a))=num2str(a-1);
                        c(I(i,a))=1+c(I(i,a));
                    end
                    c(lengthc+1)=sum(B);
                    lengthc=length(c);
                    i=i+1;
            else
                for a=1:e+1
                    code(a)=num2str(a);
                end
            end
        else
            [B,I(i,:)]=mink(c,D);
            if find(I(i,:)>lengthp)
                for b=1:D
                    if I(i,b)>lengthp
                        digit=num2str(b-1);
                        digitn(I(i,b),1)=digit;
                        c(I(i,b))=1+c(I(i,b));
                    else
                        digit=num2str(b-1);
                        code(I(i,b),1)=strcat(digit,code(I(i,b),1));
                        c(I(i,b))=1+c(I(i,b));
                    end
                end
                c(lengthc+1)=sum(B);
                lengthc=length(c);
                i=i+1;
            else
                for b=1:D
                    digit=num2str(b-1);
                    code(I(i,b),1)=strcat(digit,code(I(i,b),1));
                    c(I(i,b))=1+c(I(i,b));
                end
                c(lengthc+1)=sum(B);
                lengthc=length(c);
                i=i+1;
            end
        end
    end
    lengthdn=length(digitn);
    m=lengthdn;
    for n=lengthp:lengthdn-1
        p=m-lengthp;
        digitn(I(p,:),1)=strcat(digitn(m,1),digitn(I(p,:),1));
        m=m-1;
    end
end
for n=1:lengthp
    code(n,1)=strcat(digitn(n),code(n,1));
end
for n=1:e+1
    letterlength(n)=strlength(code(n));
end
avelength=sum(letterprob.*letterlength);
disp(I)
for n=1:e+1
    sprintf('%s %s',letterinfile(n),code(n))
end
end

