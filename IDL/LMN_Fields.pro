



lmn = strarr(1)
lmn = 'y'
L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]

;L = [1, 0, 0]
;M = [0, 1, 0]
;N = [0, 0, 1]

L = [0.971, 0.216, -0.106]
M = [-0.234,0.948, -0.215]
N = [0.054, 0.233, 0.971]

;11/28
;L = [0.177617, -0.158717, 0.971216]
;M = [0.244648, -0.948804, -0.199795]
;N = [0.953205, 0.273093, -0.129694]

L = [0.93, 0.3, -0.2]
M = [-0.27, 0.2, -0.94]
N = [-0.24, 0.93, 0.27]


get_data,'mms1_edp_dce_gse_brst_l2', data = E1
get_data,'mms2_edp_dce_gse_brst_l2', data = E2
get_data,'mms3_edp_dce_gse_brst_l2', data = E3
get_data,'mms4_edp_dce_gse_brst_l2', data = E4

get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = B1_vec
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = B2_vec
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = B3_vec
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = B4_vec


get_data, 'mms1_fgm_b_gse_brst_l2_btot', data = B1
get_data, 'mms2_fgm_b_gse_brst_l2_btot', data = B2
get_data, 'mms3_fgm_b_gse_brst_l2_btot', data = B3
get_data, 'mms4_fgm_b_gse_brst_l2_btot', data = B4

get_data, 'mms1_des_bulkv_gse_brst', data = v1
get_data, 'mms2_des_bulkv_gse_brst', data = v2
get_data, 'mms3_des_bulkv_gse_brst', data = v3
get_data, 'mms4_des_bulkv_gse_brst', data = v4

get_data, 'mms1_mec_r_gse', DATA=mec1
get_data, 'mms2_mec_r_gse', DATA=mec2
get_data, 'mms3_mec_r_gse', DATA=mec3
get_data, 'mms4_mec_r_gse', DATA=mec4

E1 = 1e-3*interp(E1.y, E1.x, t)
E2 = 1e-3*interp(E2.y, E2.x, t)
E3 = 1e-3*interp(E3.y, E3.x, t)
E4 = 1e-3*interp(E4.y, E4.x, t)


;stop
B1 = 1e-9*interp(B1.y, B1.x, t)
B2 = 1e-9*interp(B2.y, B2.x, t)
B3 = 1e-9*interp(B3.y, B3.x, t)
B4 = 1e-9*interp(B4.y, B4.x, t)

B1_vec = 1e-9*interp(B1_vec.y, B1_vec.x, t)
B2_vec = 1e-9*interp(B2_vec.y, B2_vec.x, t)
B3_vec = 1e-9*interp(B3_vec.y, B3_vec.x, t)
B4_vec = 1e-9*interp(B4_vec.y, B4_vec.x, t)

r1 = 1e3*interp(mec1.y, mec1.x, t)
r2 = 1e3*interp(mec2.y, mec2.x, t)
r3 = 1e3*interp(mec3.y, mec3.x, t)
r4 = 1e3*interp(mec4.y, mec4.x, t)
;stop
v1 = 1e3*interp(v1.y, v1.x, t)
v2 = 1e3*interp(v2.y, v2.x, t)
v3 = 1e3*interp(v3.y, v3.x, t)
v4 = 1e3*interp(v4.y, v4.x, t)










;int = (0.2)*33.3
int = (0)*128
if (int ne 0) then begin
  for i = 0,2 do begin
    E1[*,i] = smooth(E1[*,i],int)
    E2[*,i] = smooth(E2[*,i],int)
    E3[*,i] = smooth(E3[*,i],int)
    E4[*,i] = smooth(E4[*,i],int)

    ;v1[*,i] = smooth(v1[*,i],int)
    ;v2[*,i] = smooth(v2[*,i],int)
    ;v3[*,i] = smooth(v3[*,i],int)
    ;v4[*,i] = smooth(v4[*,i],int)



    B1_vec[*,i] = smooth(B1_vec[*,i],int)
    B2_vec[*,i] = smooth(B2_vec[*,i],int)
    B3_vec[*,i] = smooth(B3_vec[*,i],int)
    B4_vec[*,i] = smooth(B4_vec[*,i],int)
  endfor
endif


if (lmn eq 'y') then begin
  transf = [[L],[M],[N]]


  E1_L = E1[*,0]*L[0] + E1[*,1]*L[1] + E1[*,2]*L[2]
  E1_M = E1[*,0]*M[0] + E1[*,1]*M[1] + E1[*,2]*M[2]
  E1_N = E1[*,0]*N[0] + E1[*,1]*N[1] + E1[*,2]*N[2]
  
  E2_L = E2[*,0]*L[0] + E2[*,1]*L[1] + E2[*,2]*L[2]
  E2_M = E2[*,0]*M[0] + E2[*,1]*M[1] + E2[*,2]*M[2]
  E2_N = E2[*,0]*N[0] + E2[*,1]*N[1] + E2[*,2]*N[2]

  E3_L = E3[*,0]*L[0] + E3[*,1]*L[1] + E3[*,2]*L[2]
  E3_M = E3[*,0]*M[0] + E3[*,1]*M[1] + E3[*,2]*M[2]
  E3_N = E3[*,0]*N[0] + E3[*,1]*N[1] + E3[*,2]*N[2]

  E4_L = E4[*,0]*L[0] + E4[*,1]*L[1] + E4[*,2]*L[2]
  E4_M = E4[*,0]*M[0] + E4[*,1]*M[1] + E4[*,2]*M[2]
  E4_N = E4[*,0]*N[0] + E4[*,1]*N[1] + E4[*,2]*N[2]

  B1_L = B1_vec[*,0]*L[0] + B1_vec[*,1]*L[1] + B1_vec[*,2]*L[2]
  B1_M = B1_vec[*,0]*M[0] + B1_vec[*,1]*M[1] + B1_vec[*,2]*M[2]
  B1_N = B1_vec[*,0]*N[0] + B1_vec[*,1]*N[1] + B1_vec[*,2]*N[2]

  B2_L = B2_vec[*,0]*L[0] + B2_vec[*,1]*L[1] + B2_vec[*,2]*L[2]
  B2_M = B2_vec[*,0]*M[0] + B2_vec[*,1]*M[1] + B2_vec[*,2]*M[2]
  B2_N = B2_vec[*,0]*N[0] + B2_vec[*,1]*N[1] + B2_vec[*,2]*N[2]
  
  B3_L = B3_vec[*,0]*L[0] + B3_vec[*,1]*L[1] + B3_vec[*,2]*L[2]
  B3_M = B3_vec[*,0]*M[0] + B3_vec[*,1]*M[1] + B3_vec[*,2]*M[2]
  B3_N = B3_vec[*,0]*N[0] + B3_vec[*,1]*N[1] + B3_vec[*,2]*N[2]
  
  B4_L = B4_vec[*,0]*L[0] + B4_vec[*,1]*L[1] + B4_vec[*,2]*L[2]
  B4_M = B4_vec[*,0]*M[0] + B4_vec[*,1]*M[1] + B4_vec[*,2]*M[2]
  B4_N = B4_vec[*,0]*N[0] + B4_vec[*,1]*N[1] + B4_vec[*,2]*N[2]
  
  r1_L = r1[*,0]*L[0] + r1[*,1]*L[1] + r1[*,2]*L[2]
  r1_M = r1[*,0]*M[0] + r1[*,1]*M[1] + r1[*,2]*M[2]
  r1_N = r1[*,0]*N[0] + r1[*,1]*N[1] + r1[*,2]*N[2]
  
  r2_L = r2[*,0]*L[0] + r2[*,1]*L[1] + r2[*,2]*L[2]
  r2_M = r2[*,0]*M[0] + r2[*,1]*M[1] + r2[*,2]*M[2]
  r2_N = r2[*,0]*N[0] + r2[*,1]*N[1] + r2[*,2]*N[2]
  
  r3_L = r3[*,0]*L[0] + r3[*,1]*L[1] + r3[*,2]*L[2]
  r3_M = r3[*,0]*M[0] + r3[*,1]*M[1] + r3[*,2]*M[2]
  r3_N = r3[*,0]*N[0] + r3[*,1]*N[1] + r3[*,2]*N[2]
  
  r4_L = r4[*,0]*L[0] + r4[*,1]*L[1] + r4[*,2]*L[2]
  r4_M = r4[*,0]*M[0] + r4[*,1]*M[1] + r4[*,2]*M[2]
  r4_N = r4[*,0]*N[0] + r4[*,1]*N[1] + r4[*,2]*N[2]
  
  E1 = [[E1_L],[E1_M],[E1_N]]
  E2 = [[E2_L],[E2_M],[E2_N]]
  E3 = [[E3_L],[E3_M],[E3_N]]
  E4 = [[E4_L],[E4_M],[E4_N]]
  
  B1 = [[B1_L],[B1_M],[B1_N]]
  B2 = [[B2_L],[B2_M],[B2_N]]
  B3 = [[B3_L],[B3_M],[B3_N]]
  B4 = [[B4_L],[B4_M],[B4_N]]
  
  r1 = [[r1_L],[r1_M],[r1_N]]
  r2 = [[r2_L],[r2_M],[r2_N]]
  r3 = [[r3_L],[r3_M],[r3_N]]
  r4 = [[r4_L],[r4_M],[r4_N]]




endif

transf = [[L],[M],[N]]





;stop


N = n_elements(t)
Ex_avg = fltarr(N)
Ey_avg = fltarr(N)
Ez_avg = fltarr(N)
Bx_avg = fltarr(N)
By_avg = fltarr(N)
Bz_avg = fltarr(N)
Sx = fltarr(N)
Sy = fltarr(N)
Sz = fltarr(N)
S1_L = fltarr(N)
S1_M = fltarr(N)
S1_N = fltarr(N)
S2_L = fltarr(N)
S2_M = fltarr(N)
S2_N = fltarr(N)
S3_L = fltarr(N)
S3_M = fltarr(N)
S3_N = fltarr(N)
S4_L = fltarr(N)
S4_M = fltarr(N)
S4_N = fltarr(N)
;r1 = fltarr(N,3)
;r2 = fltarr(N,3)
;r3 = fltarr(N,3)
;r4 = fltarr(N,3)

;stop
for i = 1, N-1 do begin
  
  S1_L[i] = E1[i,1]*B1[i,2] - E1[i,2]*B1[i,1]
  S1_M[i] = E1[i,2]*B1[i,0] - E1[i,0]*B1[i,2]
  S1_N[i] = E1[i,0]*B1[i,1] - E1[i,1]*B1[i,0]

  S2_L[i] = E2[i,1]*B2[i,2] - E2[i,2]*B2[i,1]
  S2_M[i] = E2[i,2]*B2[i,0] - E2[i,0]*B2[i,2]
  S2_N[i] = E2[i,0]*B2[i,1] - E2[i,1]*B2[i,0]

  S3_L[i] = E3[i,1]*B3[i,2] - E3[i,2]*B3[i,1]
  S3_M[i] = E3[i,2]*B3[i,0] - E3[i,0]*B3[i,2]
  S3_N[i] = E3[i,0]*B3[i,1] - E3[i,1]*B3[i,0]

  S4_L[i] = E4[i,1]*B4[i,2] - E4[i,2]*B4[i,1]
  S4_M[i] = E4[i,2]*B4[i,0] - E4[i,0]*B4[i,2]
  S4_N[i] = E4[i,0]*B4[i,1] - E4[i,1]*B4[i,0]


  ;Compute components of average Poynting vector over all SC
  Sx[i] = Ex_avg[i]*Bz_avg[i] - Ez_avg[i]*By_avg[i]
  Sy[i] = Ez_avg[i]*Bx_avg[i] - Ex_avg[i]*Bz_avg[i]
  Sz[i] = Ex_avg[i]*By_avg[i] - Ey_avg[i]*Bx_avg[i]
endfor


S1 = [[S1_L],[S1_M],[S1_N]]/mu0
S2 = [[S2_L],[S2_M],[S2_N]]/mu0
S3 = [[S3_L],[S3_M],[S3_N]]/mu0
S4 = [[S4_L],[S4_M],[S4_N]]/mu0


div_S = unh_recipdiv(r1, r2, r3, r4, S1, S2, S3, S4)
store_data, 'Div_S_LMN', data = {x:t, y: 1e9*div_S}
end