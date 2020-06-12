function f = MouseFiles(MouseID, Day)

%%% load file names of Ca imaging data and TM position data



MouseID;
Day;



switch MouseID
    
    
    
    %%%%%%%%%%%%%%%%%%%% WT %%%%%%%%%%%%%%%%%%%%
    
    case 1    
    switch Day %WT1_m17
        case 1
            Ca_name='070317_M17_zeroone_selected';
            OF_name='070317 TM-SA_d1 M17-n2 CaMKII_WT_XY';
        case 2
            Ca_name='070417_M17_zeroone_selected';
            OF_name='070417 TM-SA_d2 M17-n2 CaMKII_WT_XY';                       
        case 3
            Ca_name='070517_M17_zeroone_selected';
            OF_name='070517 TM-SA_d3 M17-n2 CaMKII_WT_XY';                       
        case 4
            Ca_name='070617_M17_zeroone_selected';
            OF_name='070617 TM-SA_d4 M17-n2 CaMKII_WT_XY';                       
        case 5
            Ca_name='070717_M17_zeroone_selected';
            OF_name='070717 TM-SA_d5 M17-n2 CaMKII_WT_XY';                        
        case 6
            Ca_name='071017_M17_zeroone_selected';
            OF_name='071017 TM-SA_delay1 M17-n2 CaMKII_WT_XY';
        case 7
            Ca_name='071117_M17_zeroone_selected';
            OF_name='071117 TM-SA_delay2 M17-n2 CaMKII_WT_XY';            
        case 8
            Ca_name='071217_M17_zeroone_selected';
            OF_name='071217 TM-SA_delay3 M17-n2 CaMKII_WT_XY';
    end
    
    
    case 2 
    switch Day %WT2_m28
        case 1
            Ca_name='M28TM_d1_registered_traces';
            OF_name='M28TM_d1_registered_position';
        case 2
            Ca_name='M28TM_d2_registered_traces';
            OF_name='M28TM_d2_registered_position';
        case 3
            Ca_name='M28TM_d3_registered_traces';
            OF_name='M28TM_d3_registered_position';
        case 4
            Ca_name='M28TM_d4_registered_traces';
            OF_name='M28TM_d4_registered_position';
        case 5
            Ca_name='M28TM_d5_registered_traces';
            OF_name='M28TM_d5_registered_position';
        case 6
            Ca_name='M28TM_d6_registered_traces';
            OF_name='M28TM_d6_registered_position';
        case 7
            Ca_name='M28TM_d7_delay_registered_traces';
            OF_name='M28TM_d7_delay_registered_position';     
    end
    
    
    
    case 3   
    switch Day %WT3_m29
        case 1
            Ca_name='M29TM_d1_registered_traces';
            OF_name='M29TM_d1_registered_position';    
        case 2
            Ca_name='M29TM_d2_registered_traces';
            OF_name='M29TM_d2_registered_position';    
        case 3
            Ca_name='M29TM_d3_registered_traces';
            OF_name='M29TM_d3_registered_position';    
        case 4
            Ca_name='M29TM_d4_registered_traces';
            OF_name='M29TM_d4_registered_position';    
        case 5
            Ca_name='M29TM_d5_registered_traces';
            OF_name='M29TM_d5_registered_position';    
        case 6
            Ca_name='M29TM_d6_registered_traces';
            OF_name='M29TM_d6_registered_position';    
        case 7
            Ca_name='M29TM_d7_delay_registered_traces';
            OF_name='M29TM_d7_delay_registered_position';    
    end
     
    
    case 4
    switch Day %WT_m2
        case 1
            Ca_name='M2TM_d1_registered_traces';
            OF_name='M2TM_d1_registered_position';              
        case 2
            Ca_name='M2TM_d2_registered_traces';
            OF_name='M2TM_d2_registered_position';                
        case 3
            Ca_name='M2TM_d3_registered_traces';
            OF_name='M2TM_d3_registered_position';                 
        case 4
            Ca_name='M2TM_d4_registered_traces';
            OF_name='M2TM_d4_registered_position';          
        case 5
            Ca_name='M2TM_d5_registered_traces';
            OF_name='M2TM_d5_registered_position';                
    end    
    
    
    case 5
    switch Day %WT_m5
        case 1
            Ca_name='M5TM_d1_registered_traces';
            OF_name='M5TM_d1_registered_position';              
        case 2
            Ca_name='M5TM_d2_registered_traces';
            OF_name='M5TM_d2_registered_position';            
        case 3
            Ca_name='M5TM_d3_S1_registered_traces';
            OF_name='M5TM_d3_S1_registered_position';                 
        case 4
            Ca_name='M5TM_d4_registered_traces';
            OF_name='M5TM_d4_registered_position';          
        case 5
            Ca_name='M5TM_d5_registered_traces';
            OF_name='M5TM_d5_registered_position';                
    end
    
    
    case 6
    switch Day %WT_m59
        case 1
            Ca_name='M59_B6J_TM_d1_registered_traces';
            OF_name='M59_B6J_TM_d1_registered_position';              
        case 2
            Ca_name='M59_B6J_TM_d2_registered_traces';
            OF_name='M59_B6J_TM_d2_registered_position';                 
        case 3
            Ca_name='M59_B6J_TM_d3_registered_traces';
            OF_name='M59_B6J_TM_d3_registered_position';                 
        case 4
            Ca_name='M59_B6J_TM_d4_registered_traces';
            OF_name='M59_B6J_TM_d4_registered_position';            
        case 5
            Ca_name='M59_B6J_TM_d5_registered_traces';
            OF_name='M59_B6J_TM_d5_registered_position';                 
    end 
    
    
    
    
    case 7
    switch Day %WT_RN3
        case 1
            Ca_name='WT_RN1TM_d1_registered_traces';
            OF_name='XY_position_CK_WT_RN3_TM_d1';              
        case 2
            Ca_name='WT_RN1TM_d2_registered_traces';
            OF_name='XY_position_CK_WT_RN3_TM_d2';          
        case 3
            Ca_name='WT_RN1TM_d3_registered_traces';
            OF_name='XY_position_CK_WT_RN3_TM_d3';                
        case 4
            Ca_name='WT_RN1TM_d4_registered_traces';
            OF_name='XY_position_CK_WT_RN3_TM_d4';           
        case 5
            Ca_name='WT_RN1TM_d5_registered_traces';
            OF_name='XY_position_CK_WT_RN3_TM_d5';                
    end
    
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%% CaMK %%%%%%%%%%%%%%%%%%%%
    
    case 8
    switch Day %CaMK1_m19
        case 1
            Ca_name='M19TM_d1_registered_traces';
            OF_name='M19TM_d1_registered_position';            
        case 2
            Ca_name='M19TM_d2_registered_traces';
            OF_name='M19TM_d2_registered_position';
        case 3
            Ca_name='M19TM_d3_registered_traces';
            OF_name='M19TM_d3_registered_position';
        case 4
            Ca_name='M19TM_d4_registered_traces';
            OF_name='M19TM_d4_registered_position';
        case 5
            Ca_name='M19TM_d5_registered_traces';
            OF_name='M19TM_d5_registered_position'; 
    end
    
    
    
    case 9
    switch Day %CaMK2_m22
        case 1
            Ca_name='070317_M22_zeroone_selected';
            OF_name='070317 TM-SA_d1 M22-n1 CaMKII_HKO_XY';              
        case 2
            Ca_name='070417_M22_zeroone_selected';
            OF_name='070417 TM-SA_d2 M22-n1 CaMKII_HKO_XY';  
        case 3
            Ca_name='070517_M22_zeroone_selected';
            OF_name='070517 TM-SA_d3 M22-n1 CaMKII_HKO_XY';  
        case 4
            Ca_name='070617_M22_zeroone_selected';
            OF_name='070617 TM-SA_d4 M22-n1 CaMKII_HKO_XY';  
        case 5
            Ca_name='070717_M22_zeroone_selected';
            OF_name='070717 TM-SA_d5 M22-n1 CaMKII_HKO_XY';  
        case 6
            Ca_name='071017_M22_zeroone_selected';
            OF_name='071017 TM-SA_delay1 M22-n1 CaMKII_HKO_XY';  
        case 7
            Ca_name='071117_M22_zeroone_selected';
            OF_name='071117 TM-SA_delay2 M22-n1 CaMKII_HKO_XY';  
        case 8
            Ca_name='071217_M22_zeroone_selected';
            OF_name='071217 TM-SA_delay3 M22-n1 CaMKII_HKO_XY';
    end
    
    
    
    case 10
    switch Day %CaMK3_m30
        case 1
            Ca_name='M30TM_d1_registered_traces';
            OF_name='M30TM_d1_registered_position';              
        case 2
            Ca_name='M30TM_d2_registered_traces';
            OF_name='M30TM_d2_registered_position';              
        case 3
            Ca_name='M30TM_d3_registered_traces';
            OF_name='M30TM_d3_registered_position';              
        case 4
            Ca_name='M30TM_d4_registered_traces';
            OF_name='M30TM_d4_registered_position';              
        case 5
            Ca_name='M30TM_d5_registered_traces';
            OF_name='M30TM_d5_registered_position';               
        case 6
            Ca_name='M30TM_d6_registered_traces';
            OF_name='M30TM_d6_registered_position';              
        case 7
            Ca_name='M30TM_d7_delay_registered_traces';
            OF_name='M30TM_d7_delay_registered_position';  
    end
    
    
    
    
    case 11
    switch Day %CaMK_RN1 % Very good
        case 1
            Ca_name='RN1TM_d1_registered_traces';
            OF_name='XY_position_CK_KO_RN1_TM_d1';              
        case 2
            Ca_name='RN1TM_d2_registered_traces';
            OF_name='XY_position_CK_KO_RN1_TM_d2';          
        case 3
            Ca_name='RN1TM_d3_registered_traces';
            OF_name='XY_position_CK_KO_RN1_TM_d3';                
        case 4
            Ca_name='RN1TM_d4_registered_traces';
            OF_name='XY_position_CK_KO_RN1_TM_d4';           
        case 5
            Ca_name='RN1TM_d5_registered_traces';
            OF_name='XY_position_CK_KO_RN1_TM_d5';                
    end
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%% No use %%%%%%%%%%%%%%%%%%%%
    
    
    case 9999
    switch Day %CaMK_RN2 % NG
        case 1
            Ca_name='RN2TM_d1_registered_traces';
            OF_name='XY_position_CK_KO_RN2_TM_d1';              
        case 2
            Ca_name='RN2TM_d2_registered_traces';
            OF_name='XY_position_CK_KO_RN2_TM_d2';          
        case 3
            Ca_name='RN2TM_d3_registered_traces';
            OF_name='XY_position_CK_KO_RN2_TM_d3';                
        case 4
            Ca_name='RN2TM_d4_registered_traces';
            OF_name='XY_position_CK_KO_RN2_TM_d4';           
        case 5
            Ca_name='RN2TM_d5_registered_traces';
            OF_name='XY_position_CK_KO_RN2_TM_d5';                
    end
    
    
    case 9999
    switch Day %WT_m7
        case 1
            Ca_name='M7TM_d1_registered_traces';
            OF_name='M7TM_d1_registered_position';              
        case 2
            Ca_name='M7TM_d2_registered_traces';
            OF_name='M7TM_d2_registered_position';          
        case 3
            Ca_name='M7TM_d3_registered_traces';
            OF_name='M7TM_d3_registered_position';                
        case 4
            Ca_name='M7TM_d4_registered_traces';
            OF_name='M7TM_d4_registered_position';           
        case 5
            Ca_name='M7TM_d5_S1_registered_traces';
            OF_name='M7TM_d5_S1_registered_position';                
    end
    
    
end

f = {Ca_name OF_name};

end
