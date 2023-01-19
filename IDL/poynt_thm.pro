;;Poynting's Theorem. Computes the Convective derivative of the EM energy density
;


;;--------------------------
;; Define Physical constants
;;---------------------------
e0 = 8.85e-12    ;C/N(m^2)
mu0 = 12.5664e-7 ;N/(A^2)
e = 1.602e-19    ; Coulombs
me = 9.11e-31    ; kg
mi = 1.67e-27    ; kg



;;---------------------------------------------------------
;; Set Timespan and Load data from the primary instruments
;;---------------------------------------------------------
probe = ['1','2','3','4']
sc = 'mms' + probe

;timespan,'2015-10-16/13:05:30',2.5 , /Minute
;timespan,'2016-01-10/09:13:10',1 , /minute
timespan,'2017-07-11/22:34:00',6 , /second
;timespan,'2016-11-23/07:49:00',2 , /Minute
;timespan,'2016-11-28/07:36:50',10 , /second
;timespan,'2016-12-11/04:40:00',3 , /Minute
;timespan,'2015-10-16/13:06:55',10 , /second
;timespan,'2015-10-16/13:03:00',5 , /minute
;timespan,'2015-10-31/07:17:00', 2.5 , /minute
;timespan,'2017-06-17/20:24:02',10 , /second
; timespan,'2015-12-14/01:17:37',12 , /second
;timespan,'2016-10-22/12:59:12',4 , /second
;timespan,'2017-05-28/04:00:00',2 , /minute
;timespan,'2017-08-10/12:18:30',10 , /second
;timespan,'2015-12-06/23:38:29',5 , /second
;timespan,'2015-12-06/23:38:29',5 , /second





;mms_load_edp,level = 'l2',data_rate = 'brst',probes = probe, /time_clip
;mms_load_fpi,data_rate = 'brst',probes = probe,/time_clip
;mms_load_fgm,level = 'l2',data_rate = 'brst',probes = probe,/time_clip
;mms_load_mec,level = 'l2',data_rate = 'srvy',probes = probe,/time_clip

;stop

frame = 'sc'    ;'xline' --> X-line frame
;'sc'    --> Spacecraft frame
;'e'     --> Electron frame



;Get necessary data from each SC




l3 = strarr(1)
l3 = 'n'            ;;;;;for l3 merged efield data, use l3 = 'y', otherwise edp by default
if (l3 eq 'y') then begin
  Tplot_restore, FILENAME='/Users/d0118dominic/data/mms/' + sc + '/MMS' + probe + '_July11_2017_GSE_R02.tplot', /VERBOSE
  for probe_idx = 0, n_elements(probe)-1 do begin
    sc = 'mms'+strcompress(string(probe[probe_idx]), /rem)
    get_data, sc + '_fpi_edp_Ex_gse_l2', data = Ex
    get_data, sc + '_fpi_edp_Ey_gse_l2', data = Ey
    get_data, sc + '_fpi_edp_Ez_gse_l2', data = Ez

    ;;This is just E
    store_data, sc + '_Ex', data = {x: Ex.x, y: Ex.y[*,0]}
    store_data, sc + '_Ey', data = {x: Ey.x, y: Ey.y[*,0]}
    store_data, sc + '_Ez', data = {x: Ez.x, y: Ez.y[*,0]}

    ;;This is E - VexB = E - Econv
    store_data, sc + '_Ex', data = {x: Ex.x, y: Ex.y[*,0] + Ex.y[*,2]}
    store_data, sc + '_Ey', data = {x: Ey.x, y: Ey.y[*,0] + Ey.y[*,2]}
    store_data, sc + '_Ez', data = {x: Ez.x, y: Ez.y[*,0] + Ez.y[*,2]}

    N = n_elements(Ex.x)
    Esc = fltarr(N,3)


    ;;This is just E
    E = [[Ex.y[*,0]], [Ey.y[*,0]], [Ez.y[*,0]]]

    ;;This is E + VexB = E - Econv
    ;E = [[Ex.y[*,0]- Ex.y[*,2]], [Ey.y[*,0]- Ey.y[*,2]], [Ez.y[*,0]- Ez.y[*,2]]]
    ;
    ;E = [[- Ex.y[*,2]], [- Ey.y[*,2]], [- Ez.y[*,2]]]
    ;;This is E + VxB
    ;vsb_x = -175
    ;vsb_y = 20
    ;vsb_z = -36
    ;E = [[Ex.y[*,0]+vsb_x], [Ey.y[*,0]+ vsb_y], [Ez.y[*,0]+vsb_z]]
    store_data, sc + '_E_mrg', data = {x:Ex.x, y:E}
  endfor
  ;stop



  get_data, 'mms1_E_mrg', data = E1
  get_data, 'mms2_E_mrg', data = E2
  get_data, 'mms3_E_mrg', data = E3
  get_data, 'mms4_E_mrg', data = E4

endif else begin
  get_data,'mms1_edp_dce_gse_brst_l2', data = E1
  get_data,'mms2_edp_dce_gse_brst_l2', data = E2
  get_data,'mms3_edp_dce_gse_brst_l2', data = E3
  get_data,'mms4_edp_dce_gse_brst_l2', data = E4
endelse



;stop



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
;stop
get_data, 'mms1_des_numberdensity_brst', data = ne1
get_data, 'mms2_des_numberdensity_brst', data = ne2
get_data, 'mms3_des_numberdensity_brst', data = ne3
get_data, 'mms4_des_numberdensity_brst', data = ne4


;Interpolate to electron timescale;
get_data, 'mms1_edp_dce_gse_brst_l2', data = t
get_data, 'mms1_des_bulkv_gse_brst', data = ve1
get_data, 'mms1_dis_bulkv_gse_brst', data = vi1
;get_data, 'mms4_edi_flux1_0_brst_l2', data = te
t = B1_vec.x
t = ve1.x
;t = time
N = n_elements(t)
;t = vi1.x
;te = te.x



;stop

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



ne1 = 1e6*interp(ne1.y, ne1.x, t)
ne2 = 1e6*interp(ne2.y, ne2.x, t)
ne3 = 1e6*interp(ne3.y, ne3.x, t)
ne4 = 1e6*interp(ne4.y, ne4.x, t)
;stop
r1 = fltarr(n_elements(t),3)
r2 = fltarr(n_elements(t),3)
r3 = fltarr(n_elements(t),3)
r4 = fltarr(n_elements(t),3)
;stop
for i = 0,2 do begin
  r1[*,i] = 1000*mec1.y[0,i]
  r2[*,i] = 1000*mec2.y[0,i]
  r3[*,i] = 1000*mec3.y[0,i]
  r4[*,i] = 1000*mec4.y[0,i]
endfor



;stop


; Smoothing of (electric) fields
; Set int to the desired timespan.  Set int = 0 for no smoothing
int = (0.0)*33.3
;int = (0.0)*128
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
  ;B1 = smooth(B1, int)
  ;B2 = smooth(B2, int)
  ;B3 = smooth(B3, int)
  ;B4 = smooth(B4, int)
endif


;stop

;Break E & B into components (and convert to SI)
E1_x = E1[*,0]
E1_y = E1[*,1]
E1_z = E1[*,2]
E2_x = E2[*,0]
E2_y = E2[*,1]
E2_z = E2[*,2]
E3_x = E3[*,0]
E3_y = E3[*,1]
E3_z = E3[*,2]
E4_x = E4[*,0]
E4_y = E4[*,1]
E4_z = E4[*,2]
B1_x = B1_vec[*,0]
B1_y = B1_vec[*,1]
B1_z = B1_vec[*,2]
B2_x = B2_vec[*,0]
B2_y = B2_vec[*,1]
B2_z = B2_vec[*,2]
B3_x = B3_vec[*,0]
B3_y = B3_vec[*,1]
B3_z = B3_vec[*,2]
B4_x = B4_vec[*,0]
B4_y = B4_vec[*,1]
B4_z = B4_vec[*,2]



;;;Computing ExB Drift Velocity;;;

VD1x = fltarr(N,3)
VD1y = fltarr(N,3)
VD1z = fltarr(N,3)
VD2x = fltarr(N,3)
VD2y = fltarr(N,3)
VD2z = fltarr(N,3)
VD3x = fltarr(N,3)
VD3y = fltarr(N,3)
VD3z = fltarr(N,3)
VD4x = fltarr(N,3)
VD4y = fltarr(N,3)
VD4z = fltarr(N,3)

VD1x = (E1[*,1]*B1_vec[*,2] - E1[*,2]*B1_vec[*,1])
VD1y = (E1[*,2]*B1_vec[*,0] - E1[*,0]*B1_vec[*,2])
VD1z = (E1[*,0]*B1_vec[*,1] - E1[*,1]*B1_vec[*,0])

VD2x = (E2[*,1]*B2_vec[*,2] - E2[*,2]*B2_vec[*,1])
VD2y = (E2[*,2]*B2_vec[*,0] - E2[*,0]*B2_vec[*,2])
VD2z = (E2[*,0]*B2_vec[*,1] - E2[*,1]*B2_vec[*,0])

VD3x = (E3[*,1]*B3_vec[*,2] - E3[*,2]*B3_vec[*,1])
VD3y = (E3[*,2]*B3_vec[*,0] - E3[*,0]*B3_vec[*,2])
VD3z = (E3[*,0]*B3_vec[*,1] - E3[*,1]*B3_vec[*,0])

VD4x = (E4[*,1]*B4_vec[*,2] - E4[*,2]*B4_vec[*,1])
VD4y = (E4[*,2]*B4_vec[*,0] - E4[*,0]*B4_vec[*,2])
VD4z = (E4[*,0]*B4_vec[*,1] - E4[*,1]*B4_vec[*,0])

VD1 = [[VD1x],[VD1y],[VD1z]]
VD2 = [[VD2x],[VD2y],[VD2z]]
VD3 = [[VD3x],[VD3y],[VD3z]]
VD4 = [[VD4x],[VD4y],[VD4z]]

VDx = strarr(n_elements(t))
VDy = strarr(n_elements(t))
VDz = strarr(n_elements(t))
for i = 0,n_elements(t)-1 do begin
  VDx[i] = (VD1[i,0] + VD2[i,0] + VD3[i,0] + VD4[i,0])/((B1[i]+B2[i]+B3[i]+B4[i])^2)
  VDy[i] = (VD1[i,1] + VD2[i,1] + VD3[i,1] + VD4[i,1])/((B1[i]+B2[i]+B3[i]+B4[i])^2)
  VDz[i] = (VD1[i,2] + VD2[i,2] + VD3[i,2] + VD4[i,2])/((B1[i]+B2[i]+B3[i]+B4[i])^2)
endfor



;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;

;stop


;vsx = VDx
;vsy = VDy
;vsz = VDz



; X-line Velocity here
vsx = -175000
vsy = 20000
vsz = -36000
;;;;;;;;;;;;;;;;;;;;;
q = strarr(1)


;q = 'y'
if (frame eq 'xline') then begin
  E1_x = E1_x + vsy*B1_z - vsz*B1_y
  E1_y = E1_y + vsz*B1_x - vsx*B1_z
  E1_z = E1_z + vsx*B1_y - vsy*B1_x
  E2_x = E2_x + vsy*B2_z - vsz*B2_y
  E2_y = E2_y + vsz*B2_x - vsx*B2_z
  E2_z = E2_z + vsx*B2_y - vsy*B2_x
  E3_x = E3_x + vsy*B3_z - vsz*B3_y
  E3_y = E3_y + vsz*B3_x - vsx*B3_z
  E3_z = E3_z + vsx*B3_y - vsy*B3_x
  E4_x = E4_x + vsy*B4_z - vsz*B4_y
  E4_y = E4_y + vsz*B4_x - vsx*B4_z
  E4_z = E4_z + vsx*B4_y - vsy*B4_x

  E1[*,0] = E1[*,0] + vsy*B1_vec[*,2] - vsz*B1_vec[*,1]
  E1[*,1] = E1[*,1] + vsz*B1_vec[*,0] - vsx*B1_vec[*,2]
  E1[*,2] = E1[*,2] + vsx*B1_vec[*,1] - vsy*B1_vec[*,0]
  E2[*,0] = E2[*,0] + vsy*B2_vec[*,2] - vsz*B2_vec[*,1]
  E2[*,1] = E2[*,1] + vsz*B2_vec[*,0] - vsx*B2_vec[*,2]
  E2[*,2] = E2[*,2] + vsx*B2_vec[*,1] - vsy*B2_vec[*,0]
  E3[*,0] = E3[*,0] + vsy*B3_vec[*,2] - vsz*B3_vec[*,1]
  E3[*,1] = E3[*,1] + vsz*B3_vec[*,0] - vsx*B3_vec[*,2]
  E3[*,2] = E3[*,2] + vsx*B3_vec[*,1] - vsy*B3_vec[*,0]
  E4[*,0] = E4[*,0] + vsy*B4_vec[*,2] - vsz*B4_vec[*,1]
  E4[*,1] = E4[*,1] + vsz*B4_vec[*,0] - vsx*B4_vec[*,2]
  E4[*,2] = E4[*,2] + vsx*B4_vec[*,1] - vsy*B4_vec[*,0]

  ;E1 = [[E1__x],[E1__y],[E1__z]]
  ;E2 = [[E2__x],[E2__y],[E2__z]]
  ;E3 = [[E3__x],[E3__y],[E3__z]]
  ;E4 = [[E4__x],[E4__y],[E4__z]]
endif


;stop

;Compute EM energy densities for each spacecraft (with factors to put B --> Tesla)
E1_sqrd = E1[*,0]^2 + E1[*,1]^2 + E1[*,2]^2
E2_sqrd = E2[*,0]^2 + E2[*,1]^2 + E2[*,2]^2
E3_sqrd = E3[*,0]^2 + E3[*,1]^2 + E3[*,2]^2
E4_sqrd = E4[*,0]^2 + E4[*,1]^2 + E4[*,2]^2
u1 = (e0/2)*E1_sqrd + ((B1^2)/(2*mu0))
u2 = (e0/2)*E2_sqrd + ((B2^2)/(2*mu0))
u3 = (e0/2)*E3_sqrd + ((B3^2)/(2*mu0))
u4 = (e0/2)*E4_sqrd + ((B4^2)/(2*mu0))


grad_u = unh_recipgrad(r1,r2,r3,r4,u1,u2,u3,u4)










;; Compute time derivative of energy density, du/dt
N = n_elements(t)
du1 = fltarr(N)
du2 = fltarr(N)
du3 = fltarr(N)
du4 = fltarr(N)
for i= 1, N-1 do begin
  du1[i] = (u1[i] - u1[i-1])/(t[i]- t[i- 1])
  du2[i] = (u2[i] - u2[i-1])/(t[i]- t[i- 1])
  du3[i] = (u3[i] - u3[i-1])/(t[i]- t[i- 1])
  du4[i] = (u4[i] - u4[i-1])/(t[i]- t[i- 1])
endfor

du_avg = fltarr(N)
for i = 1, N-1 do begin
  du_avg[i] = (du1[i] + du2[i] + du3[i] + du4[i])/4
  ;  du_avg[i] = (du1[i] - (VD1x*grad_u[*,0] + VD1y*grad_u[*,1] + VD1z*grad_u[*,2]) $
  ;             + du2[i] - (VD2x*grad_u[*,0] + VD2y*grad_u[*,1] + VD2z*grad_u[*,2]) $
  ;             + du3[i] - (VD3x*grad_u[*,0] + VD3y*grad_u[*,1] + VD3z*grad_u[*,2]) $
  ;             + du4[i] - (VD4x*grad_u[*,0] + VD4y*grad_u[*,1] + VD4z*grad_u[*,2]))/4
endfor




;Compute gradient of scalar u




;Break v into components and compute average vx,vy,vz for all SC

if (frame eq 'e') then begin
  v_x = (v1[*,0] + v2[*,0] + v3[*,0] + v4[*,0])/4
  v_y = (v1[*,1] + v2[*,1] + v3[*,1] + v4[*,1])/4
  v_z = (v1[*,2] + v2[*,2] + v3[*,2] + v4[*,2])/4
endif else begin
  if(frame eq 'xline') then begin
    v_x = Vsx
    v_y = Vsy
    v_z = Vsz
  endif
endelse






;;Structure Velocity;;  vsb based on b reversal, vse based on electron jet reversal;;

;vsb_x =strarr(n_elements(t))
;vsb_y =strarr(n_elements(t))
;vsb_z =strarr(n_elements(t))
;vse_x =strarr(n_elements(t))
;vse_y =strarr(n_elements(t))
;vse_z =strarr(n_elements(t))

;vsb_x = -175000
;vsb_y = 20000
;vsb_z = -36000
;
;vse_x = -36000
;vse_y = 7000
;vse_z = -167000



;dvx = abs(vse_x - vsb_x)
;dvy = abs(vse_y - vsb_y)
;dvz = abs(vse_z - vsb_z)

;v_x = v_x[*] - dvx
;v_y = v_y[*] - dvy
;v_z = v_z[*] - dvz

;stop



;Make spatial and temporal components of conv derivative and combine
conv_s = v_x*grad_u[*,0] + v_y*grad_u[*,1] + v_z*grad_u[*,2]
conv_t = du_avg - conv_s
conv_total = du_avg

;conv_t = smooth(conv_t, int)

store_data, 'Conv_s', data = {x:t, y: 1e9*conv_s}
store_data, 'Conv_t', data = {x:t, y: 1e9*conv_t}
store_data, 'Conv_total', data = {x:t, y: 1e9*conv_total}





;;;DIVERGENCE OF POYNTING FLUX


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
S1x = fltarr(N)
S1y = fltarr(N)
S1z = fltarr(N)
S2x = fltarr(N)
S2y = fltarr(N)
S2z = fltarr(N)
S3x = fltarr(N)
S3y = fltarr(N)
S3z = fltarr(N)
S4x = fltarr(N)
S4y = fltarr(N)
S4z = fltarr(N)
;r1 = fltarr(N,3)
;r2 = fltarr(N,3)
;r3 = fltarr(N,3)
;r4 = fltarr(N,3)

;stop
for i = 1, N-1 do begin
  Ex_avg[i] = (E1[i,0] + E2[i,0] + E3[i,0] + E4[i,0])/4
  Ey_avg[i] = (E1[i,1] + E2[i,1] + E3[i,1] + E4[i,1])/4
  Ez_avg[i] = (E1[i,2] + E2[i,2] + E3[i,2] + E4[i,2])/4

  Bx_avg[i] = (B1_vec[i,0] + B2_vec[i,0] + B3_vec[i,0] + B4_vec[i,0])/4
  By_avg[i] = (B1_vec[i,1] + B2_vec[i,1] + B3_vec[i,1] + B4_vec[i,1])/4
  Bz_avg[i] = (B1_vec[i,2] + B2_vec[i,2] + B3_vec[i,2] + B4_vec[i,2])/4


  S1x[i] = E1[i,1]*B1_vec[i,2] - E1[i,2]*B1_vec[i,1]
  S1y[i] = E1[i,2]*B1_vec[i,0] - E1[i,0]*B1_vec[i,2]
  S1z[i] = E1[i,0]*B1_vec[i,1] - E1[i,1]*B1_vec[i,0]

  S2x[i] = E2[i,1]*B2_vec[i,2] - E2[i,2]*B2_vec[i,1]
  S2y[i] = E2[i,2]*B2_vec[i,0] - E2[i,0]*B2_vec[i,2]
  S2z[i] = E2[i,0]*B2_vec[i,1] - E2[i,1]*B2_vec[i,0]

  S3x[i] = E3[i,1]*B3_vec[i,2] - E3[i,2]*B3_vec[i,1]
  S3y[i] = E3[i,2]*B3_vec[i,0] - E3[i,0]*B3_vec[i,2]
  S3z[i] = E3[i,0]*B3_vec[i,1] - E3[i,1]*B3_vec[i,0]

  S4x[i] = E4[i,1]*B4_vec[i,2] - E4[i,2]*B4_vec[i,1]
  S4y[i] = E4[i,2]*B4_vec[i,0] - E4[i,0]*B4_vec[i,2]
  S4z[i] = E4[i,0]*B4_vec[i,1] - E4[i,1]*B4_vec[i,0]


  ;Compute components of average Poynting vector over all SC
  Sx[i] = Ex_avg[i]*Bz_avg[i] - Ez_avg[i]*By_avg[i]
  Sy[i] = Ez_avg[i]*Bx_avg[i] - Ex_avg[i]*Bz_avg[i]
  Sz[i] = Ex_avg[i]*By_avg[i] - Ey_avg[i]*Bx_avg[i]
endfor


S1 = [[S1x],[S1y],[S1z]]/mu0
S2 = [[S2x],[S2y],[S2z]]/mu0
S3 = [[S3x],[S3y],[S3z]]/mu0
S4 = [[S4x],[S4y],[S4z]]/mu0

;x = 1
;if x = 1 do begin
;get_data, 'S_Hall_mms1', data = S1
;get_data, 'S_Hall_mms2', data = S2
;get_data, 'S_Hall_mms3', data = S3
;get_data, 'S_Hall_mms4', data = S4

;endif

store_data, 'S1', data = {x:t, y:S1}
store_data, 'S2', data = {x:t, y:S2}
store_data, 'S3', data = {x:t, y:S3}
store_data, 'S4', data = {x:t, y:S4}


;get_data, 'mms1_mec_r_gse', DATA=mec1
;get_data, 'mms2_mec_r_gse', DATA=mec2
;get_data, 'mms3_mec_r_gse', DATA=mec3
;get_data, 'mms4_mec_r_gse', DATA=mec4






;stop

;div_S = (unh_recipdiv(r1, r2, r3, r4, S1, S2, S3, S4))/((ne1 + ne2 + ne3 + ne4)/4)
div_S = unh_recipdiv(r1, r2, r3, r4, S1, S2, S3, S4)

;div_S = smooth(div_S,int)

store_data, 'Div_S', data = {x:t, y: 1e9*div_S}


















;;;  J_dot_E:  Rate of work by the fields

;Get bulk velocities from each SC
get_data, 'mms1_dis_bulkv_gse_brst', data = vi1
get_data, 'mms2_dis_bulkv_gse_brst', data = vi2
get_data, 'mms3_dis_bulkv_gse_brst', data = vi3
get_data, 'mms4_dis_bulkv_gse_brst', data = vi4
get_data, 'mms1_des_bulkv_gse_brst', data = ve1
get_data, 'mms2_des_bulkv_gse_brst', data = ve2
get_data, 'mms3_des_bulkv_gse_brst', data = ve3
get_data, 'mms4_des_bulkv_gse_brst', data = ve4



;Interpolate v to fgm time
vi1 = 1.5*1e3*interp(vi1.y, vi1.x, t)
vi2 = 1.5*1e3*interp(vi2.y, vi2.x, t)
vi3 = 1.5*1e3*interp(vi3.y, vi3.x, t)
vi4 = 1.5*1e3*interp(vi4.y, vi4.x, t)
ve1 = 1e3*interp(ve1.y, ve1.x, t)
ve2 = 1e3*interp(ve2.y, ve2.x, t)
ve3 = 1e3*interp(ve3.y, ve3.x, t)
ve4 = 1e3*interp(ve4.y, ve4.x, t)

;for i=0,2 do begin
;  vi1[*,i] = smooth(vi1[*,i], int)
;  vi2[*,i] = smooth(vi2[*,i], int)
;  vi3[*,i] = smooth(vi3[*,i], int)
;  vi4[*,i] = smooth(vi4[*,i], int)
;  ve1[*,i] = smooth(vi1[*,i], int)
;  ve2[*,i] = smooth(vi2[*,i], int)
;  ve3[*,i] = smooth(vi3[*,i], int)
;  ve4[*,i] = smooth(vi4[*,i], int)
;endfor


;Convert v to m/s
;for i=0,2 do begin
;  vi1[*,i] = 1.5*1000*vi1[*,i]
;  vi2[*,i] = 1.5*1000*vi2[*,i]
;  vi3[*,i] = 1.5*1000*vi3[*,i]
;  vi4[*,i] = 1.5*1000*vi4[*,i]
;  ve1[*,i] = 1000*ve1[*,i]
;  ve2[*,i] = 1000*ve2[*,i]
;  ve3[*,i] = 1000*ve3[*,i]
;  ve4[*,i] = 1000*ve4[*,i]
;endfor



;;;;;;; E' = E + Ve X B:::
m = strarr(1)
m = 'n'
if (m eq 'y') then begin
  E1_x = E1_x + ve1[*,1]*B1_z - ve1[*,2]*B1_y
  E1_y = E1_y + ve1[*,2]*B1_x - ve1[*,0]*B1_z
  E1_z = E1_z + ve1[*,0]*B1_y - ve1[*,1]*B1_x
  E2_x = E2_x + ve2[*,1]*B2_z - ve2[*,2]*B2_y
  E2_y = E2_y + ve2[*,2]*B2_x - ve2[*,0]*B2_z
  E2_z = E2_z + ve2[*,0]*B2_y - ve2[*,1]*B2_x
  E3_x = E3_x + ve3[*,1]*B3_z - ve3[*,2]*B3_y
  E3_y = E3_y + ve3[*,2]*B3_x - ve3[*,0]*B3_z
  E3_z = E3_z + ve3[*,0]*B3_y - ve3[*,1]*B3_x
  E4_x = E4_x + ve4[*,1]*B4_z - ve4[*,2]*B4_y
  E4_y = E4_y + ve4[*,2]*B4_x - ve4[*,0]*B4_z
  E4_z = E4_z + ve4[*,0]*B4_y - ve4[*,1]*B4_x


  ;E1 = [[E1__x],[E1__y],[E1__z]]
  ;E2 = [[E2__x],[E2__y],[E2__z]]
  ;E3 = [[E3__x],[E3__y],[E3__z]]
  ;E4 = [[E4__x],[E4__y],[E4__z]]
endif

;;;;;;;;;;;;;;



get_data, 'mms1_des_numberdensity_brst', data = ne1
get_data, 'mms2_des_numberdensity_brst', data = ne2
get_data, 'mms3_des_numberdensity_brst', data = ne3
get_data, 'mms4_des_numberdensity_brst', data = ne4
get_data, 'mms1_dis_numberdensity_brst', data = ni1
get_data, 'mms2_dis_numberdensity_brst', data = ni2
get_data, 'mms3_dis_numberdensity_brst', data = ni3
get_data, 'mms4_dis_numberdensity_brst', data = ni4

ni1 = 1e6*interp(ni1.y, ni1.x, t)
ni2 = 1e6*interp(ni2.y, ni2.x, t)
ni3 = 1e6*interp(ni3.y, ni3.x, t)
ni4 = 1e6*interp(ni4.y, ni4.x, t)
ne1 = 1e6*interp(ne1.y, ne1.x, t)
ne2 = 1e6*interp(ne2.y, ne2.x, t)
ne3 = 1e6*interp(ne3.y, ne3.x, t)
ne4 = 1e6*interp(ne4.y, ne4.x, t)

;ni1 = smooth(ni1, int)
;ni2 = smooth(ni2, int)
;ni3 = smooth(ni3, int)
;ni4 = smooth(ni4, int)
;ne1 = smooth(ne1, int)
;ne2 = smooth(ni2, int)
;ne3 = smooth(ni3, int)
;ne4 = smooth(ni4, int)

;stop
e = 1.602e-19    ; Coulombs
J1 = fltarr(N,3)
J2 = fltarr(N,3)
J3 = fltarr(N,3)
J4 = fltarr(N,3)
J_avg = fltarr(N,3)
for i=0,2 do begin
  J1[*,i] = e*ne1*(vi1[*,i] - ve1[*,i])
  J2[*,i] = e*ne2*(vi1[*,i] - ve2[*,i])
  J3[*,i] = e*ne3*(vi1[*,i] - ve3[*,i])
  J4[*,i] = e*ne4*(vi1[*,i] - ve4[*,i])

  ;J1[*,i] = e*ne1*(vi1[*,i] - ve1[*,i] - VD1[*,i])
  ;J2[*,i] = e*ne2*(vi1[*,i] - ve2[*,i] - VD2[*,i])
  ;J3[*,i] = e*ne3*(vi1[*,i] - ve3[*,i] - VD3[*,i])
  ;J4[*,i] = e*ne4*(vi1[*,i] - ve4[*,i] - VD4[*,i])
endfor

;;Getting both J_avg and J_Curlo;;
for i = 0,2 do begin
  J_avg[*,i] = (J1[*,i] + J2[*,i] + J3[*,i] + J4[*,i])/4
endfor
E_avg = [[Ex_avg],[Ey_avg],[Ez_avg]]

Curl_B = unh_recipcurl(r1, r2, r3, r4, B1_vec, B2_vec, B3_vec, B4_vec)
J_curlo = Curl_B/(mu0)    ;;divide by qn_e?
store_data, 'J_avg', data = {x:t, y:1e9*J_avg} ;nA/m^2
store_data, 'J_curlo', data = {x:t, y:1e9*J_curlo} ;nA/m^2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;stop

;;PER PARTICLE!!!;;
;EdotJ1 = (E1_x*J1[*,0] + E1_y*J1[*,1] + E1_z*J1[*,2])/ne1
;EdotJ2 = (E2_x*J2[*,0] + E2_y*J2[*,1] + E2_z*J2[*,2])/ne2
;EdotJ3 = (E3_x*J3[*,0] + E3_y*J3[*,1] + E3_z*J3[*,2])/ne3
;EdotJ4 = (E4_x*J4[*,0] + E4_y*J4[*,1] + E4_z*J4[*,2])/ne4

;EdotJ1 = (E1_x*J1[*,0] + E1_y*J1[*,1] + E1_z*J1[*,2])
;EdotJ2 = (E2_x*J2[*,0] + E2_y*J2[*,1] + E2_z*J2[*,2])
;EdotJ3 = (E3_x*J3[*,0] + E3_y*J3[*,1] + E3_z*J3[*,2])
;EdotJ4 = (E4_x*J4[*,0] + E4_y*J4[*,1] + E4_z*J4[*,2])

EdotJ_curl = E_avg[*,0]*J_curlo[*,0] + E_avg[*,1]*J_curlo[*,1] + E_avg[*,2]*J_curlo[*,2]
;EdotJ_avg = (EdotJ1 + EdotJ2 + EdotJ3 + EdotJ4)/4
EdotJ_avg = E_avg[*,0]*J_avg[*,0] + E_avg[*,1]*J_avg[*,1] + E_avg[*,2]*J_avg[*,2]
;EdotJ_avg = smooth(EdotJ_avg, int)

store_data, 'E.J_mom', data = {x:t, y:1e9*EdotJ_avg}
store_data, 'E.J_curl', data = {x:t, y:1e9*EdotJ_curl}
;store_data, 'E.J', data = {x:t, y:1e9*EdotJ4}


store_data, '-div(S)-E.J', data = {x:t,y:-1e9*(EdotJ_curl + div_S)}


;colors = mms_color(['blue', 'green', 'red', 'black'], DECOMPOSED=0)


store_data, 'J_Diff', data = {x:t, y:1e9*[[abs(J_avg[*,0] - J_curlo[*,0])],[abs(J_avg[*,1] - J_curlo[*,1])],[abs(J_avg[*,2] - J_curlo[*,2])]]}
options, 'J_Diff', 'colors', colors[0:2]
options, 'J_Diff', 'labels', ['∆Jx','∆Jy','∆Jz']
options, 'J_Diff', 'labflag', 1



ej1 = (E1[*,0]*J1[*,0] + E1[*,1]*J1[*,1] + E1[*,2]*J1[*,2])
ej2 = (E2[*,0]*J2[*,0] + E2[*,1]*J2[*,1] + E2[*,2]*J2[*,2])
ej3 = (E3[*,0]*J3[*,0] + E3[*,1]*J3[*,1] + E3[*,2]*J3[*,2])
ej4 = (E4[*,0]*J4[*,0] + E4[*,1]*J4[*,1] + E4[*,2]*J4[*,2])

ds1 = -du1-ej1
ds2 = -du2-ej2
ds3 = -du3-ej3
ds4 = -du4-ej4

store_data, 'ds_all', data = {x:t, y: 1e9*[[ds1],[ds2],[ds3],[ds4]]}
options, 'ds_all', 'colors', colors[0:3]
options, 'ds_all', 'labels', ['MMS1','MMS2','MMS3','MMS4']
options, 'ds_all', 'labflag', 1

store_data, 'ej_all', data = {x:t, y: 1e9*[[ej1],[ej2],[ej3],[ej4]]}
options, 'ej_all', 'colors', colors[0:3]
options, 'ej_all', 'labels', ['MMS1','MMS2','MMS3','MMS4']
options, 'ej_all', 'labflag', 1

store_data, 'du_all', data = {x:t, y: 1e9*[[du1],[du2],[du3],[du4]]}
options, 'du_all', 'colors', colors[0:3]
options, 'du_all', 'labels', ['MMS1','MMS2','MMS3','MMS4']
options, 'du_all', 'labflag', 1

comparisons = ['ej_all','ds_all','du_all']

store_data, 'ds_mom', data = {x:t, y: 1e9* (ds1+ds2+ds3+ds4)/4}
options, 'ds_mom', 'ytitle', 'Div_S_avg!C(nW/m^3)'

get_data, 'E.J_curl', data = ejc
get_data, 'E.J_mom', data = ejm
get_data, 'ds_mom', data = dsm
get_data, 'Div_S', data = dsc
store_data, 'ejc_plus_dsm', data = {x:t, y: ejc.y+dsm.y}

store_data, 'ejds', data = {x:t, y:[[ejc.y],[dsm.y]]}
options, 'ejds', 'colors', colors[1:2]
options, 'ejds', 'ytitle', 'E.J_curl & Div_S_avg!C(nW/m^3)'
options, 'ejds', 'labels', ['E.J', 'Div(S)']
options, 'ejds', 'labflag', 1


store_data, 'dsds', data = {x:t, y:[[dsc.y],[dsm.y]]}
options, 'dsds', 'colors', colors[1:2]
options, 'dsds', 'ytitle', 'Div_S_c & Div_S_avg!C(nW/m^3)'
options, 'dsds', 'labels', ['Div_S_c', 'Div(S)_avg']
options, 'dsds', 'labflag', 1

;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;
;;;;;;;;;;;;;
;;;;;;;;;;;;
;;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;
;;;;;;;;
;;;;;;;
;;;;;;
;;;;;
;;;;
;;;
;;
;

;----------------------------------
;Coordinate transformation to LMN
;----------------------------------

stop
lmn = strarr(1)
lmn = 'y'

L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]


;12/06/2015
;L = [0.02, -0.51, 0.86]
;M = [0.566, 0.711, 0.408]
;N = [0.82, -0.48, -0.30]


;6/17/2017
;L = [0.93, 0.3, -0.2]
;M = [-0.27, 0.2, -0.94]
;N = [-0.24, 0.93, 0.27]


;10/16
;L = [0.3665, -0.1201, 0.9226]
;M = [0.5694, -0.7553, -0.3245]   ;;NO!!
;N = [0.7358, 0.6443, -0.2084]

;10/16
;L = [0.3665, 0.5694, 0.7358]
;M = [-0.1201, -0.7553, 0.6443]
;N = [0.9226, -0.3245, -0.2084]


;10/31
;L = [0.890, 0.309, -0.335]
;M = [0.333, 0.0627, 0.941]
;N = [0.311, -0.949, -0.0470]

if (lmn eq 'y') then begin
  transf = [[L],[M],[N]]


  E_L = E_avg[*,0]*L[0] + E_avg[*,1]*L[1] + E_avg[*,2]*L[2]
  E_M = E_avg[*,0]*M[0] + E_avg[*,1]*M[1] + E_avg[*,2]*M[2]
  E_N = E_avg[*,0]*N[0] + E_avg[*,1]*N[1] + E_avg[*,2]*N[2]

  J_L = J_avg[*,0]*L[0] + J_avg[*,1]*L[1] + J_avg[*,2]*L[2]
  J_M = J_avg[*,0]*M[0] + J_avg[*,1]*M[1] + J_avg[*,2]*M[2]
  J_N = J_avg[*,0]*N[0] + J_avg[*,1]*N[1] + J_avg[*,2]*N[2]

  ;J_L = J_curlo[*,0]*L[0] + J_curlo[*,1]*L[1] + J_curlo[*,2]*L[2]
  ;J_M = J_curlo[*,0]*M[0] + J_curlo[*,1]*M[1] + J_curlo[*,2]*M[2]
  ;J_N = J_curlo[*,0]*N[0] + J_curlo[*,1]*N[1] + J_curlo[*,2]*N[2]


  E_lmn = [[E_L],[E_M],[E_N]]
  J_lmn = [[J_L],[J_M],[J_N]]

  EJ_lmn = fltarr(n_elements(t),3)
  for i = 0,2 do begin
    EJ_lmn[*,i] = E_lmn[*,i]*J_lmn[*,i]
  endfor


  store_data, 'E_lmn', data = {x:t, y:1e3*E_lmn}
  store_data, 'J_lmn', data = {x:t, y:1e6*J_lmn}
  store_data, 'JlEl', data = {x:t, y:1e9*J_L*E_L}
  store_data, 'JmEm', data = {x:t, y:1e9*J_M*E_M}
  store_data, 'JnEn', data = {x:t, y:1e9*J_N*E_N}
  store_data, 'J.E_lmn', data = {x:t, y:1e9*(J_M*E_M + J_L*E_L +J_N*E_N)}


endif






;;;;;;;;;;;;;;
;;;;;;;;;;;;;;
;;;;;;;;;;;;;;




;colors = mms_color(['blue', 'green', 'red', 'black'], DECOMPOSED=0)



options, 'J_avg', 'ytitle', "J_avg"
options, 'J_avg', 'colors', colors[0:2]
options, 'J_avg', 'labels', ['Jx','Jy','Jz']
options, 'J_avg', 'labflag', 1

options, 'J_curlo', 'ytitle', "J_Curlo"
options, 'J_curlo', 'colors', colors[0:2]
options, 'J_curlo', 'labels', ['Jx','Jy','Jz']
options, 'J_curlo', 'labflag', 1

options, 'E_lmn', 'ytitle', 'E !C(mV/m)'
options, 'E_lmn', 'colors', colors[0:2]
options, 'E_lmn', 'labels', ['L', 'M', 'N']
options, 'E_lmn', 'labflag', 1

options, 'J_lmn', 'ytitle', 'J !C(µA/m^2)'
options, 'J_lmn', 'colors', colors[0:2]
options, 'J_lmn', 'labels', ['L', 'M', 'N']
options, 'J_lmn', 'labflag', 1

options, 'JmEm', 'ytitle', 'J.E_M !C(nW/m^3)'

options, 'Div_S', 'ytitle', 'Div(S) !C(nW/m^3)'
options, 'E.J_mom', 'ytitle', 'E.J(S) !C(nW/m^3)'




if (frame eq 'sc') then begin
  get_data, 'Conv_total', data = dudt
endif else begin
  if(frame ne 'sc') then begin
    get_data, 'Conv_t', data = dudt
  endif
endelse



stop

get_data, 'E.J_curl', data = ej
get_data, 'Div_S', data = ds

store_data, 'ejandds', data = {x:t, y: [[-ej.y],[ds.y],[-dudt.y]]}

options, 'ejandds', 'colors', colors[1:3]
options, 'ejandds', 'ytitle', 'Poynting Terms!C(nW/m^3)
options, 'ejandds', 'labels', ['-J.E', 'Div(S)', '-du/dt']
options, 'ejandds', 'labflag', 1




;----------------------------------------------------------
; Divergence of other energy flux quantities (in progress)
;----------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;Enthalpy;;;;;;;;;;;;;;;;;;;;;;
;c = 2.5

;get_data, 'mms1_dis_prestensor_gse_brst', data = Pi1
;get_data, 'mms2_dis_prestensor_gse_brst', data = Pi2
;get_data, 'mms3_dis_prestensor_gse_brst', data = Pi3
;get_data, 'mms4_dis_prestensor_gse_brst', data = Pi4
;get_data, 'mms1_des_prestensor_gse_brst', data = Pe1
;get_data, 'mms2_des_prestensor_gse_brst', data = Pe2
;get_data, 'mms3_des_prestensor_gse_brst', data = Pe3
;get_data, 'mms4_des_prestensor_gse_brst', data = Pe4

;Pi_1 = Pi1.y[*,0,0] + Pi1.y[*,1,1] + Pi1.y[*,2,2]
;Pi_2 = Pi2.y[*,0,0] + Pi2.y[*,1,1] + Pi2.y[*,2,2]
;Pi_3 = Pi3.y[*,0,0] + Pi3.y[*,1,1] + Pi3.y[*,2,2]
;Pi_4 = Pi4.y[*,0,0] + Pi4.y[*,1,1] + Pi4.y[*,2,2]
;Pe_1 = Pe1.y[*,0,0] + Pe1.y[*,1,1] + Pe1.y[*,2,2]
;Pe_2 = Pe2.y[*,0,0] + Pe2.y[*,1,1] + Pe2.y[*,2,2]
;Pe_3 = Pe3.y[*,0,0] + Pe3.y[*,1,1] + Pe3.y[*,2,2]
;Pe_4 = Pe4.y[*,0,0] + Pe4.y[*,1,1] + Pe4.y[*,2,2]

;Pi1 = {x: Pi1.x, y: Pi_1}
;Pi2 = {x: Pi2.x, y: Pi_2}
;Pi3 = {x: Pi3.x, y: Pi_3}
;Pi4 = {x: Pi4.x, y: Pi_4}
;Pe1 = {x: Pe1.x, y: Pe_1}
;Pe2 = {x: Pe2.x, y: Pe_2}
;Pe3 = {x: Pe3.x, y: Pe_3}
;Pe4 = {x: Pe4.x, y: Pe_4}

;calc (gamma/gamma-1)*P and convert nPa ---> Pa
;Pi1 = 1e-9*interp(Pi1.y, Pi1.x, t)
;Pi2 = 1e-9*interp(Pi2.y, Pi2.x, t)
;Pi3 = 1e-9*interp(Pi3.y, Pi3.x, t)
;Pi4 = 1e-9*interp(Pi4.y, Pi4.x, t)
;Pe1 = 1e-9*interp(Pe1.y, Pe1.x, t)
;Pe2 = 1e-9*interp(Pe2.y, Pe2.x, t)
;Pe3 = 1e-9*interp(Pe3.y, Pe3.x, t)
;Pe4 = 1e-9*interp(Pe4.y, Pe4.x, t)

;Hi1 = fltarr(N,3)
;Hi2 = fltarr(N,3)
;Hi3 = fltarr(N,3)
;Hi4 = fltarr(N,3)
;He1 = fltarr(N,3)
;He2 = fltarr(N,3)
;He3 = fltarr(N,3)
;He4 = fltarr(N,3)
;for i=0,2 do begin
;  Hi1[*,i] = c*Pi1*vi1[*,i]
;  Hi2[*,i] = c*Pi2*vi2[*,i]
;  Hi3[*,i] = c*Pi3*vi3[*,i]
;  Hi4[*,i] = c*Pi4*vi4[*,i]
;  He1[*,i] = c*Pe1*ve1[*,i]
;  He2[*,i] = c*Pe2*ve2[*,i]
;  He3[*,i] = c*Pe3*ve3[*,i]
;  He4[*,i] = c*Pe4*ve4[*,i]
;endfor

;div_Hi = unh_recipdiv(r1, r2, r3, r4, Hi1, Hi2, Hi3, Hi4)
;div_He = unh_recipdiv(r1, r2, r3, r4, He1, He2, He3, He4)

;store_data, 'Div_Hi', data = {x: t, y: 1e9*div_Hi}
;store_data, 'Div_He', data = {x: t, y: 1e9*div_He}




;;;;;;;;;;;;;;;;;;;;;Kinetic;;;;;;;;;;;;;;;;;;;;;;

;(Velocity)^2 magnitudes

;ve1_sqrd = ve1[*,0]^2 + ve1[*,1]^2 + ve1[*,2]^2
;ve2_sqrd = ve2[*,0]^2 + ve2[*,1]^2 + ve2[*,2]^2
;ve3_sqrd = ve3[*,0]^2 + ve3[*,1]^2 + ve3[*,2]^2
;ve4_sqrd = ve4[*,0]^2 + ve4[*,1]^2 + ve4[*,2]^2
;vi1_sqrd = vi1[*,0]^2 + vi1[*,1]^2 + vi1[*,2]^2
;vi2_sqrd = vi2[*,0]^2 + vi2[*,1]^2 + vi2[*,2]^2
;vi3_sqrd = vi3[*,0]^2 + vi3[*,1]^2 + vi3[*,2]^2
;vi4_sqrd = vi4[*,0]^2 + vi4[*,1]^2 + vi4[*,2]^2

;Kinetic Energy Density
;Ke1_E = (me/2)*ne1*ve1_sqrd
;Ke2_E = (me/2)*ne2*ve2_sqrd
;Ke3_E = (me/2)*ne3*ve3_sqrd
;Ke4_E = (me/2)*ne4*ve4_sqrd
;Ki1_E = (mi/2)*ni1*vi1_sqrd
;Ki2_E = (mi/2)*ni2*vi2_sqrd
;Ki3_E = (mi/2)*ni3*vi3_sqrd
;Ki4_E = (mi/2)*ni4*vi4_sqrd

;Ke1 = fltarr(N,3)
;Ke2 = fltarr(N,3)
;Ke3 = fltarr(N,3)
;Ke4 = fltarr(N,3)
;Ki1 = fltarr(N,3)
;Ki2 = fltarr(N,3)
;Ki3 = fltarr(N,3)
;Ki4 = fltarr(N,3)

;Kinetic energy flux
;for i=0,2 do begin
;  Ke1[*,i] = Ke1_E[i]*ve1[*,i]
;  Ke2[*,i] = Ke2_E[i]*ve2[*,i]
;  Ke3[*,i] = Ke3_E[i]*ve3[*,i]
;  Ke4[*,i] = Ke4_E[i]*ve4[*,i]
;  Ki1[*,i] = Ki1_E[i]*vi1[*,i]
;  Ki2[*,i] = Ki2_E[i]*vi2[*,i]
;  Ki3[*,i] = Ki3_E[i]*vi3[*,i]
;  Ki4[*,i] = Ki4_E[i]*vi4[*,i]
;endfor

;div_Ki = unh_recipdiv(r1, r2, r3, r4, Ki1, Ki2, Ki3, Ki4)
;div_Ke = unh_recipdiv(r1, r2, r3, r4, Ke1, Ke2, Ke3, Ke4)

;store_data, 'Div_Ki', data = {x: t, y: 1e9*div_Ki}
;store_data, 'Div_Ke', data = {x: t, y: 1e9*div_Ke}







;get_data, 658, data = a
;get_data, 659, data = b
;get_data, 664, data = c

;tot = fltarr(N)
;for i=0,N-1 do begin
; tot[i] = a.y[i] + b.y[i] + c.y[i]
;endfor


;store_data, 'Total', data = {x:t, y:tot}

;f = c-1

;dPi1 = fltarr(N)
;dPi2 = fltarr(N)
;dPi3 = fltarr(N)
;dPi4 = fltarr(N)
;dPe1 = fltarr(N)
;dPe2 = fltarr(N)
;dPe3 = fltarr(N)
;dPe4 = fltarr(N)
;dKi1 = fltarr(N)
;dKi2 = fltarr(N)
;dKi3 = fltarr(N)
;dKi4 = fltarr(N)
;dKe1 = fltarr(N)
;dKe2 = fltarr(N)
;dKe3 = fltarr(N)
;dKe4 = fltarr(N)
;dPi_avg = fltarr(N)
;dPe_avg = fltarr(N)
;dKi_avg = fltarr(N)
;dKe_avg = fltarr(N)

;for i= 1, N-1 do begin
;  dPi1[i] = (Pi1[i] - Pi1[i-1])/(t[i]- t[i- 1])
;  dPi2[i] = (Pi2[i] - Pi2[i-1])/(t[i]- t[i- 1])
;  dPi3[i] = (Pi3[i] - Pi3[i-1])/(t[i]- t[i- 1])
;  dPi4[i] = (Pi4[i] - Pi4[i-1])/(t[i]- t[i- 1])
;  dPe1[i] = (Pe1[i] - Pe1[i-1])/(t[i]- t[i- 1])
;  dPe2[i] = (Pe2[i] - Pe2[i-1])/(t[i]- t[i- 1])
;  dPe3[i] = (Pe3[i] - Pe3[i-1])/(t[i]- t[i- 1])
;  dPe4[i] = (Pe4[i] - Pe4[i-1])/(t[i]- t[i- 1])

;  dPi_avg[i] = f*(dPi1[i] + dPi2[i] + dPi3[i] + dPi4[i])/4
;  dPe_avg[i] = f*(dPe1[i] + dPe2[i] + dPe3[i] + dPe4[i])/4
;

;  dKi1[i] = (Ki1_E[i] - Ki1[i-1])/(t[i]- t[i- 1])
;  dKi2[i] = (Ki2_E[i] - Ki2[i-1])/(t[i]- t[i- 1])
;  dKi3[i] = (Ki3_E[i] - Ki3[i-1])/(t[i]- t[i- 1])
;  dKi4[i] = (Ki4_E[i] - Ki4[i-1])/(t[i]- t[i- 1])
;  dKe1[i] = (Ke1_E[i] - Ke1[i-1])/(t[i]- t[i- 1])
;  dKe2[i] = (Ke2_E[i] - Ke2[i-1])/(t[i]- t[i- 1])
;  dKe3[i] = (Ke3_E[i] - Ke3[i-1])/(t[i]- t[i- 1])
;  dKe4[i] = (Ke4_E[i] - Ke4[i-1])/(t[i]- t[i- 1])
;
;  dKi_avg[i] = (dPi1[i] + dKi2[i] + dKi3[i] + dKi4[i])/4
;  dKe_avg[i] = (dPe1[i] + dKe2[i] + dKe3[i] + dKe4[i])/4



;endfor

;store_data, 'dKe/dt', data = {x:t, y: 1e9*dKe_avg}
;store_data, 'dKi/dt', data = {x:t, y: 1e9*dKi_avg}
;store_data, 'dPe/dt', data = {x:t, y: 1e9*dPe_avg}
;store_data, 'dPi/dt', data = {x:t, y: 1e9*dPi_avg}







;store_data, 'temporal', data = {x:t, y: 1e9*(dKe_avg + dKi_avg + dPe_avg + dPi_avg + conv_total)}
;store_data, 'spatial', data = {x:t, y: 1e9*(div_S + div_Hi + div_He + div_Ki + div_Ke)}








end
