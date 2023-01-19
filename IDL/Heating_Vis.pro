;;;;;;;;;
;


get_data, 'mms1_dis_bulkv_gse_brst', data = v1
get_data, 'mms2_dis_bulkv_gse_brst', data = v2
get_data, 'mms3_dis_bulkv_gse_brst', data = v3
get_data, 'mms4_dis_bulkv_gse_brst', data = v4

get_data, 'mms1_des_bulkv_gse_brst', data = v1
get_data, 'mms2_des_bulkv_gse_brst', data = v2
get_data, 'mms3_des_bulkv_gse_brst', data = v3
get_data, 'mms4_des_bulkv_gse_brst', data = v4

get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = B1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = B2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = B3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = B4





;get_data, 'mms1_des_bulkv_gse_brst', data = v1
;get_data, 'mms2_des_bulkv_gse_brst', data = v2
get_data, 'mms3_des_bulkv_gse_brst', data = ve3
;get_data, 'mms4_des_bulkv_gse_brst', data = v4

get_data, 'mms1_dis_temptensor_gse_brst', data = itemp1
get_data, 'mms2_dis_temptensor_gse_brst', data = itemp2
get_data, 'mms3_dis_temptensor_gse_brst', data = itemp3
get_data, 'mms4_dis_temptensor_gse_brst', data = itemp4
get_data, 'mms1_des_temptensor_gse_brst', data = etemp1
get_data, 'mms2_des_temptensor_gse_brst', data = etemp2
get_data, 'mms3_des_temptensor_gse_brst', data = etemp3
get_data, 'mms4_des_temptensor_gse_brst', data = etemp4

get_data, 'mms1_des_temppara_brst', data = etemp1_par
get_data, 'mms1_des_tempperp_brst', data = etemp1_perp
get_data, 'mms1_dis_temppara_brst', data = itemp1_par
get_data, 'mms1_dis_tempperp_brst', data = itemp1_perp
get_data, 'mms2_des_temppara_brst', data = etemp2_par
get_data, 'mms2_des_tempperp_brst', data = etemp2_perp
get_data, 'mms2_dis_temppara_brst', data = itemp2_par
get_data, 'mms2_dis_tempperp_brst', data = itemp2_perp
get_data, 'mms3_des_temppara_brst', data = etemp3_par
get_data, 'mms3_des_tempperp_brst', data = etemp3_perp
get_data, 'mms3_dis_temppara_brst', data = itemp3_par
get_data, 'mms3_dis_tempperp_brst', data = itemp3_perp
get_data, 'mms4_des_temppara_brst', data = etemp4_par
get_data, 'mms4_des_tempperp_brst', data = etemp4_perp
get_data, 'mms4_dis_temppara_brst', data = itemp4_par
get_data, 'mms4_dis_tempperp_brst', data = itemp4_perp

get_data, 'E.J', data = ej
get_data, 'Div_S', data = ds

get_data, 'K_e_mms3', data = ke3
get_data, 'K_i_mms3', data = ki3
get_data, 'H_e_mms3', data = he3
get_data, 'H_i_mms3', data = hi3
get_data, 'S_lmn_mms3', data = sh3
;stop
;stop





;stop
;;changes for night and dayside
;V_avg = {x: v1.x, y: (v1.y[*,0] + v2.y[*,0] + v3.y[*,0] + v4.y[*,0])/4}
;B_avg = {x:B1.x, y: (B1.y[*,0] + B2.y[*,0] + B3.y[*,0] + B4.y[*,0])/4}
;;changes for night and dayside



;ej.y = smooth(ej.y,5)
;ds.y = smooth(ds.y,5)

;stop
;stop
temp = etemp3
Ti = (temp.y[*,0,0] + temp.y[*,1,1] + temp.y[*,2,2])/3
Ti = {x: temp.x, y: Ti}
;stop
;Ti = etemp4_par

;Ti = ke3
;Tii = ej
;stop

;stop
get_data, 'mms1_des_bulkv_gse_brst', data = ve1

;t = ve1.x
t = ve3.x

Ti = interp(Ti.y, Ti.x, t)
Ti = interp(sh3.y,sh3.x,t)
;Tii = interp(Tii.y, Tii.x, t)



B1 = interp(B1.y,B1.x,t)
B2 = interp(B2.y,B2.x,t)
B3 = interp(B3.y,B3.x,t)
B4 = interp(B4.y,B4.x,t)
Bx_avg =  (B1[*,0] + B2[*,0] + B3[*,0] + B4[*,0])/4
Bz_avg =  (B1[*,2] + B2[*,2] + B3[*,2] + B4[*,2])/4


v1 = interp(v1.y, v1.x, t)
v2 = interp(v2.y, v2.x, t)
v3 = interp(v3.y, v3.x, t)
v4 = interp(v4.y, v4.x, t)
;stop
V_avg =   (v1[*,0] + v2[*,0] + v3[*,0] + v4[*,0])/4
;stop



B1_L = fltarr(n_elements(t))
B2_L = fltarr(n_elements(t))
B3_L = fltarr(n_elements(t))
B4_L = fltarr(n_elements(t))
lmn = strarr(1)
lmn = 'y'
;stop
L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]
if (lmn eq 'y') then begin
  transf = [[L],[M],[N]]

  B1_L = B1[*,0]*L[0] + B1[*,1]*L[1] + B1[*,2]*L[2]
  B2_L = B2[*,0]*L[0] + B2[*,1]*L[1] + B2[*,2]*L[2]
  B3_L = B3[*,0]*L[0] + B3[*,1]*L[1] + B3[*,2]*L[2]
  B4_L = B4[*,0]*L[0] + B4[*,1]*L[1] + B4[*,2]*L[2]
  
  V1_L = V1[*,0]*L[0] + V1[*,1]*L[1] + V1[*,2]*L[2]
  V2_L = V2[*,0]*L[0] + V2[*,1]*L[1] + V2[*,2]*L[2]
  V3_L = V3[*,0]*L[0] + V3[*,1]*L[1] + V3[*,2]*L[2]
  V4_L = V4[*,0]*L[0] + V4[*,1]*L[1] + V4[*,2]*L[2]

  b1 = b1_L
  b2 = b2_L
  b3 = b3_L
  b4 = b4_L
  
  v1 = v1_L
  v2 = v2_L
  v3 = v3_L 
  v4 = v4_L


endif

stop
;ej = interp(ej.y,ej.x,t)
;ds = interp(ds.y,ds.x,t)
;stop
;dt = 0.1
;t  = [0:100:dt]
w  = 50
l  = 5
V0 = 10000
B0 = 3
;Vi = V0 * sin(2*!pi*t/t[-1] - !pi)
;Bz = B0 * tanh(t/l - t[-1]/(l*2.0))
;Vi = V3 
;B = B3
;B = B3_L
data = ALOG(Ti)
;data = SigNum(Ti)*ALOG(Abs(Ti))
;data = Ti
;data = randomu(!Null, n_elements(t))
stop
;Create the bins of our 2D grid
Bbinsize = 0.3*0.5
Bbins    = [-B0:B0:Bbinsize]
nBbins   = n_elements(Bbins)
Vbinsize = 45*0.7
Vbins    = [-V0:V0:Vbinsize]
nVbins   = n_elements(Vbins)

;Find which bin each measurement falls into
ix = value_locate(Vbins, Vi)
iy = value_locate(Bbins, B)
;iT = value_locate(

hx = histogram(ix, REVERSE_INDICES=rix)
hy = histogram(iy, REVERSE_INDICES=riy)
;stop
;Loop over each bin
out = fltarr(nVbins, nBbins)
for i = 0, nVbins - 1 do begin
  for j = 0, nBbins - 1 do begin
    ;Find points that fall into bin [i,j]
    iAvg = where(ix eq i and iy eq j, n, COMPLEMENT=iKeep, NCOMPLEMENT=nKeep)
    if n eq 0 then continue

    ;Average the data that fall into bin [i,j]
    
    out[i,j]  = mean( data[iAvg] )
    if (out[i,j] eq 0) then begin
      out[i,j] = !values.f_nan
    endif
    

    ;Remove data that has already been averaged so that the
    ;Where() search above does not each up so much time
    if nKeep gt 0 then begin
      B[iKeep] = B[iKeep]
      Vi[iKeep] = Vi[iKeep]
    endif
  endfor
endfor



margin = [0.1, 0.03, 0.08, 0.01]
;margin = [0.1, 0.3, 0.08, 0.1]
;p1 = Plot(t, Vi, LAYOUT=[1,3,1], MARGIN=margin, YTITLE='Vi', XTITLE='t (s)')
;p2 = Plot(t, B, /CURRENT, LAYOUT=[1,3,2], MARGIN=margin, YTITLE='Bx', XTITLE='t (s)')



p3 = Image(out, Vbins,min_value = -8e-5,max_value = 8e-5,Bbins,AXIS_STYLE=2, ASPECT_RATIO = 1000, $
  XTITLE='Bz (nT)', YTITLE='Bx (nT)',POSITION = [0.1,0.1,0.9,0.9], RGB_TABLE=70)

;p3 = Image(out, Vbins,Bbins,AXIS_STYLE=2, ASPECT_RATIO = 500, $
;  XTITLE='Vix (km/s)', max_value = 900000,min_value=-900000,YTITLE='Bx (nT)',POSITION = [0.1,0.1,0.9,0.9], RGB_TABLE=25)


;use this for electron temp
;p3 = Image(out, Vbins, Bbins, MIN_VALUE = 6.2, MAX_VALUE = 6.8,AXIS_STYLE=2, ASPECT_RATIO = 800, $
;  XTITLE='Vix (km/s)', YTITLE='Bx (nT)',POSITION = [0.1,0.1,0.9,0.9], RGB_TABLE=25)

;use this for ion temp  
;p3 = Image(out, Vbins, Bbins, MIN_VALUE = 4.5, MAX_VALUE = 8.5,AXIS_STYLE=2, ASPECT_RATIO = 10, $
;   XTITLE='Vix (km/s)', YTITLE='Bx (nT)',POSITION = [0.1,0.1,0.9,0.9], RGB_TABLE=25)
      
cb = Colorbar(/RELATIVE,ORIENTATION=1,POSITION=[1.01, 0.0, 1.02, 1.0], TARGET=p3, TEXTPOS=1, TICKDIR=1, Title = 'Log(Te (ev))')


;cb = Colorbar(/normal,ORIENTATION=1, POSITION=[1.01, 0.0, 1.02, 1.0], TARGET=p3, TEXTPOS=1, TICKDIR=1)

end