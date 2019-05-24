function chList=coef_DOL(i,type)
chList=[];
global tree;
if i<=1024
    for lev=1:4
        for dir=1:4
            switch lev
                case 1
                        chList=[chList tree{dir}{lev}(i)];%数值                    
                case 2
                    for num2=1:4
                        chList=[chList tree{dir}{lev}(4*i-(4-num2))];%数值
                    end
                case 3
                    for num3=1:16
                        chList=[chList tree{dir}{lev}(16*i-(16-num3))];%数值                        
                    end
                case 4
                    for num4=1:64
                        chList=[chList tree{dir}{lev}(64*i-(64-num4))];%数值                        
                    end
            end
        end
    end
else if i<=5120
            for lev=2:4
                switch lev
                    case 2
                        for num2=1:4
                            chList=[chList tree{ceil((i-1024)/1024)}{lev}(4*(i-floor((i-1-1024)/1024)*1024-1024)-(4-num2))];%数值                            
                        end
                    case 3
                        for num3=1:16
                            chList=[chList tree{ceil((i-1024)/1024)}{lev}(16*(i-floor((i-1-1024)/1024)*1024-1024)-(16-num3))];%数值                            
                        end
                    case 4
                        for num4=1:64
                            chList=[chList tree{ceil((i-1024)/1024)}{lev}(64*(i-floor((i-1-1024)/1024)*1024-1024)-(64-num4))];%数值                            
                        end
                end
            
           end
    else if i<=21504
            
            for lev=3:4
                switch lev
                    case 3
                        for num2=1:4
                            chList=[chList tree{ceil((i-5120)/4096)}{lev}(4*(i-floor((i-1-5120)/4096)*4096-5120)-(4-num2))];%数值
                        end
                    case 4
                        for num3=1:16
                            chList=[chList tree{ceil((i-5120)/4096)}{lev}(16*(i-floor((i-1-5120)/4096)*4096-5120)-(16-num3))];%数值
                        end
                 
                end
             end
       
            
        else if i<=87040
                
                    for num4=1:4
                        chList=[chList tree{ceil((i-21504)/16384)}{4}(4*(i-floor((i-1-21504)/16384)*16384-21504)-(4-num4))];%数值
                    end
               
            else
                chList=[];
            end
        end
    end
end
if ~isempty(chList)
    switch type   
        case 'D'
        chList=chList;
        case 'O'
        chList=chList(1:4);
        case 'L'
        chList=chList(5:end);
    end
else
        chList=chList;
end
end