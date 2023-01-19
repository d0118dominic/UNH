;;;
;
;Roy's LMN
L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]


;Kevin's LMN
L = [0.9482, -0.2551, -0.1893]
M = [0.1818, 0.9245, -0.3350]
N = [0.2604, 0.2832, 0.9230]




;11/28
;L = [0.177617, -0.158717, 0.971216]
;M = [0.244648, -0.948804, -0.199795]
;N = [0.953205, 0.273093, -0.129694]


;10/16
;L = [0.3665, 0.5694, 0.7358]
;M = [-0.1201, -0.7553, 0.6443]
;N = [0.9226, -0.3245, -0.2084]

lmn = [[L],[M],[N]]
probe = ['1','2','3','4']
sc = 'mms' + probe
;ds1 = ((K1(dot)L_hat)(dot)(S1(dot)L_hat))


get_data, 'S1', data = S1
get_data, 'S2', data = S2
get_data, 'S3', data = S3
get_data, 'S4', data = S4

get_data, 'mms1_K_GSE', data = k1
get_data, 'mms2_K_GSE', data = k2
get_data, 'mms3_K_GSE', data = k3
get_data, 'mms4_K_GSE', data = k4



k1 = 1e-3*interp(k1.y,k1.x,t) ; interp to t and convert to SI units 
k2 = 1e-3*interp(k2.y,k2.x,t)
k3 = 1e-3*interp(k3.y,k3.x,t)
k4 = 1e-3*interp(k4.y,k4.x,t)


k = [k1,k2,k3,k4]

R = transpose(lmn)

kk1 = fltarr(n_elements(t),3)
kk2 = fltarr(n_elements(t),3)
kk3 = fltarr(n_elements(t),3)
kk4 = fltarr(n_elements(t),3)
ss1 = fltarr(n_elements(t),3)
ss2 = fltarr(n_elements(t),3)
ss3 = fltarr(n_elements(t),3)
ss4 = fltarr(n_elements(t),3)
ds1 = fltarr(n_elements(t))
ds2 = fltarr(n_elements(t))
ds3 = fltarr(n_elements(t))
ds4 = fltarr(n_elements(t))

for i = 0,2 do begin
  kk1[*,i] = k1[*,0]*R[i,0] + k1[*,1]*R[i,1] + k1[*,2]*R[i,2]
  ss1[*,i] = S1.y[*,0]*R[i,0] + S1.y[*,1]*R[i,1] + S1.y[*,2]*R[i,2]
  
  kk2[*,i] = k2[*,0]*R[i,0] + k2[*,1]*R[i,1] + k2[*,2]*R[i,2]
  ss2[*,i] = S2.y[*,0]*R[i,0] + S2.y[*,1]*R[i,1] + S2.y[*,2]*R[i,2]
  
  kk3[*,i] = k3[*,0]*R[i,0] + k3[*,1]*R[i,1] + k3[*,2]*R[i,2]
  ss3[*,i] = S3.y[*,0]*R[i,0] + S3.y[*,1]*R[i,1] + S3.y[*,2]*R[i,2]
  
  kk4[*,i] = k4[*,0]*R[i,0] + k4[*,1]*R[i,1] + k4[*,2]*R[i,2]
  ss4[*,i] = S4.y[*,0]*R[i,0] + S4.y[*,1]*R[i,1] + S4.y[*,2]*R[i,2]

  
  
  endfor
ds1 = kk1*ss1
ds2 = kk2*ss2
ds3 = kk3*ss3
ds4 = kk4*ss4

ds_comps = ds1 + ds2 + ds3 + ds4
store_data, 'Ds_comps', data ={x:t, y:1e9*[[ds_comps[*,0]],[ds_comps[*,1]],[ds_comps[*,2]]]}
store_data, 'Divergence_2D', data = {x:t, y: 1e9*[ds_comps[*,0] + 0*ds_comps[*,1] + ds_comps[*,2]]}
store_data, 'Full_Div(S)', data = {x:t, y: 1e9*[ds_comps[*,0] + ds_comps[*,1] + ds_comps[*,2]]}

options, 'Divergence_2D', 'colors', 'b'
options, 'Divergence_2D', 'labels', 'Div_LN'
options, 'Divergence_2D', 'labflag', 1
options, 'Divergence_2D','ytitle', 'Div(S)_2D !C(nW/m^3)'

options, 'Full_Div(S)', 'colors', 'b'
options, 'Full_Div(S)', 'labflag', 1
options, 'Full_Div(S)','ytitle', 'Div(S) !C(nW/m^3)'



end