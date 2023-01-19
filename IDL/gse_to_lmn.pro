;;;
;



PRO GSE_to_LMN

L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]

;6/17/2017
L = [0.93, 0.3, -0.2]
M = [-0.27, 0.2, -0.94]
N = [-0.24, 0.93, 0.27]

  


get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = B
get_data, 'mms1_edp_dce_gse_brst_l2', data = E
get_data, 'mms1_des_bulkv_gse_brst', data = ve
get_data, 'mms1_dis_bulkv_gse_brst', data = vi

;stop


B_L = B.y[*,0]*L[0] + B.y[*,1]*L[1] + B.y[*,2]*L[2]
B_M = B.y[*,0]*M[0] + B.y[*,1]*M[1] + B.y[*,2]*M[2]
B_N = B.y[*,0]*N[0] + B.y[*,1]*N[1] + B.y[*,2]*N[2]

E_L = E.y[*,0]*L[0] + E.y[*,1]*L[1] + E.y[*,2]*L[2]
E_M = E.y[*,0]*M[0] + E.y[*,1]*M[1] + E.y[*,2]*M[2]
E_N = E.y[*,0]*N[0] + E.y[*,1]*N[1] + E.y[*,2]*N[2]

ve_L = ve.y[*,0]*L[0] + ve.y[*,1]*L[1] + ve.y[*,2]*L[2]
ve_M = ve.y[*,0]*M[0] + ve.y[*,1]*M[1] + ve.y[*,2]*M[2]
ve_N = ve.y[*,0]*N[0] + ve.y[*,1]*N[1] + ve.y[*,2]*N[2]

vi_L = vi.y[*,0]*L[0] + vi.y[*,1]*L[1] + vi.y[*,2]*L[2]
vi_M = vi.y[*,0]*M[0] + vi.y[*,1]*M[1] + vi.y[*,2]*M[2]
vi_N = vi.y[*,0]*N[0] + vi.y[*,1]*N[1] + vi.y[*,2]*N[2]



store_data, 'B', data = {x:B.x, y:[[B_L],[B_M],[B_N]]}
store_data, 'E', data = {x:E.x, y:[[E_L],[E_M],[E_N]]}
store_data, 'Ve', data ={x:ve.x, y:[[Ve_L],[Ve_M],[Ve_N]]}
store_data, 'Vi', data ={x:vi.x, y:[[Vi_L],[Vi_M],[Vi_N]]}

names = ['B','E','Ve', 'Vi']
options, names, 'colors', ['b','g','r']
options, names, 'labels', ['L','M','N']
options, names, 'labflag', 1
options, names, 'charsize', 1.5
options, names, 'labsize', 1.5
options, names, 'charthick',2
options, names, 'thick', 2







  
  
  

end
