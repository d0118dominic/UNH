;;; Makes variables for seven types of energy flux: Heat, Enthalpy, and Kinetic energy (for e and i), and Poynting flux
;;; Variables created in both GSE and LMN coordinates given the proper LMN transformation matrix




probe = '1'
sc = 'mms' + probe

timespan,'2017-06-17/20:24:00',15 , /Second
;timespan,'2017-07-11/22:34:00',6 , /second
;timespan,'2016-11-23/07:49:00',2 , /Minute
;
;timespan,'2019-04-20/15:32:00',30 , /Second

mms_load_fpi,data_rate = 'brst',probes = probe,/time_clip
mms_load_edp,level = 'l2',data_rate = 'brst',probes = probe, /time_clip
mms_load_fgm, level = 'l2',data_rate = 'brst',probes = probe,/time_clip

get_data, sc + '_des_bulkv_gse_brst', DATA = vel_e
;get_data, sc + '_des_bulkv_dbcs_brst', data = vel_e

t = vel_e.x
N = n_elements(t)
;Constants
sc  = 'mms' + probe
e0 = 8.85e-12    ;C/N(m^2)
mu0 = 1.2566370e-06  ;m kg / C^2
m_e = 9.1093836e-31 ; kg
m_i = 1.6726219e-27 ; kg
k = 1.3806e-23 ; Boltzman Constant

;mms_load_fpi, probes = probe, data_rate = 'brst',/time_clip








;Getting all necessary base quantities;

get_data, sc + '_edp_dce_gse_brst_l2', data = E
get_data, sc + '_fgm_b_gse_brst_l2_bvec', data = B

get_data, sc + '_des_numberdensity_brst', DATA = n_e
get_data, sc + '_dis_numberdensity_brst', DATA = n_i

get_data, sc + '_des_prestensor_gse_brst', DATA = Pe_tens
get_data, sc + '_dis_prestensor_gse_brst', DATA = Pi_tens

get_data, sc + '_des_temptensor_gse_brst', DATA = Te_tens
get_data, sc + '_dis_temptensor_gse_brst', DATA = Ti_tens

get_data, sc + '_des_bulkv_gse_brst', DATA = vel_e
get_data, sc + '_dis_bulkv_gse_brst', DATA = vel_i

get_data, sc + '_des_heatq_dbcs_brst', data = Qe
get_data, sc + '_dis_heatq_dbcs_brst', data = Qi

get_data, 'mms1_dis_bulkv_gse_brst', data = vi1
get_data, 'mms1_des_bulkv_gse_brst', data = ve1


;endfor


;stop
;;;; Getting scalar P and T from tensors ;;;;;

Te = (Te_tens.y[*,0,0] + Te_tens.y[*,1,1] + Te_tens.y[*,2,2])/3
Ti = (Ti_tens.y[*,0,0] + Ti_tens.y[*,1,1] + Ti_tens.y[*,2,2])/3
Pe = (Pe_tens.y[*,0,0] + Pe_tens.y[*,1,1] + Pe_tens.y[*,2,2])/3
Pi = (Pi_tens.y[*,0,0] + Pi_tens.y[*,1,1] + Pi_tens.y[*,2,2])/3

Te = {x: Te_tens.x, y: Te}
Ti = {x: Ti_tens.x, y: Ti}
Pe = {x: Pe_tens.x, y: Pe}
Pi = {x: Pi_tens.x, y: Pi}


;;;Interpolate all data to defined t;;;;
;;;Convert to respective SI unit;;;;;;;;
E = 1e-3*interp(E.y,E.x,t)
B = 1e-9*interp(B.y,B.x,t)
n_e = 1e6*interp(n_e.y,n_e.x,t)
n_i = 1e6*interp(n_i.y,n_i.x,t)
vel_e = 1000*interp(vel_e.y,vel_e.x,t)
vel_i = 1000*interp(vel_i.y,vel_i.x,t)
Ti = 1.6e-19*interp(Ti.y, Ti.x, t)
Te = 1.6e-19*interp(Te.y, Te.x, t)
Pi = 1e-9*interp(Pi.y, Pi.x, t) ;Pascals
Pe = 1e-9*interp(Pe.y, Pe.x, t)
Qe = 1e-3*interp(Qe.y,Qe.x,t)
Qi = 1e-3*interp(Qi.y,Qi.x,t)

u_t = fltarr(n_elements(t))
u_k = fltarr(n_elements(t))
u_p = fltarr(n_elements(t))

u_te = fltarr(n_elements(t))
u_ti = fltarr(n_elements(t))

u_ke = fltarr(n_elements(t))
u_ki = fltarr(n_elements(t))

k = 1 ;since T is in units of Joules
;k = 1.3806e-23 ; Boltzman Constant
;u_t[*] = 3*k*(n_e*Te[*] + 0*n_i*Ti[*])/2
u_t[*] = 3*(Pe[*] + Pi[*])/2

u_te[*] = 3*(Pe[*] + 0*Pi[*])/2
u_ti[*] = 3*(0*Pe[*] + Pi[*])/2

;1/2 rho v^2
u_k[*] = 0.5*(m_e*n_e*((vel_e[*,0])^2 + (vel_e[*,1])^2 + (vel_e[*,2])^2) + m_i*n_i*((vel_i[*,0])^2 + (vel_i[*,1])^2 + (vel_i[*,2])^2))

u_ke[*] = 0.5*(m_e*n_e*((vel_e[*,0])^2 + (vel_e[*,1])^2 + (vel_e[*,2])^2) + 0*m_i*n_i*((vel_i[*,0])^2 + (vel_i[*,1])^2 + (vel_i[*,2])^2))
u_ki[*] = 0.5*(0*m_e*n_e*((vel_e[*,0])^2 + (vel_e[*,1])^2 + (vel_e[*,2])^2) + m_i*n_i*((vel_i[*,0])^2 + (vel_i[*,1])^2 + (vel_i[*,2])^2))


u_p = u_k + u_t
u_pe = u_ke + u_te
u_pi = u_ki + u_ti

B_sqrd = fltarr(n_elements(t))
E_sqrd = fltarr(n_elements(t))
u_em = fltarr(n_elements(t))

B_sqrd = B[*,0]^2 + B[*,1]^2 + B[*,2]^2
E_sqrd = E[*,0]^2 + E[*,1]^2 + E[*,2]^2

u_em = 0.5*(B_sqrd/mu0 + e0*E_sqrd)

;store_data, 'En_Density', data = {x:t, y:6.2e12*[[u_em],[u_p]]}
store_data, 'En_Density', data = {x:t, y:1e9*[[u_em],[u_k], [u_t]]}
store_data, 'Electrons', data = {x:t, y:1e9*[[u_em],[u_ke], [u_te]]}

names = ['En_Density', 'Electrons']
;options, 'En_Density', 'colors', ['b','r']
options, names, 'colors', ['b','r', 'k']
;options, 'En_Density', 'labels', ['EM','Plasma']
options, names, 'labels', ['EM','Kinetic', 'Thermal']
options, names, 'labflag', 1
options, 'En_Density', 'ytitle', 'Energy Density!C(nJ/m^3)'
options, 'Electrons', 'ytitle', 'Electron Energy Density!C(nJ/m^3)'


options, names, 'charsize', 1.5
options, names, 'labsize', 1.5
options, names, 'charthick',2
options, names, 'thick', 2








;;;

;-------------------------------------------
;Computing Various Energy Fluxes
;-------------------------------------------

;;;;;Heat Flux;;;;;
store_data, 'Qe_' + sc , data = {x:t,y:Qe}
store_data, 'Qi_' + sc , data = {x:t,y:Qi}
Qe_name = 'Qe_' + sc
Qi_name = 'Qi_' + sc
;;;;;;;;;;;;;;;;
;




;;;;;Kinetic Energy Flux;;;;;;
Ke = fltarr(N,3)
Ki = fltarr(N,3)

for i = 0,2 do begin
  Ke[*,i] = 0.5*m_e*n_e*(vel_e[*,i])^3
  Ki[*,i] = 0.5*m_i*n_e*(vel_i[*,i])^3
endfor

store_data, 'Ke_' + sc, data = {x:t, y:Ke}
store_data, 'Ki_'+ sc, data = {x:t, y:Ki}
Ke_name = 'Ke_' + sc
Ki_name = 'Ki_' + sc
;;;;;;;;;;;;;;;;


;;;;;Enthalpy Flux;;;;;

He = fltarr(N,3)
Hi = fltarr(N,3)

for i = 0,2 do begin
  He[*,i] = 2.5*Pe*vel_e[*,i]
  Hi[*,i] = 2.5*Pi*vel_i[*,i]
endfor

store_data, 'He_' + sc, data = {x:t, y:He}
store_data, 'Hi_'+ sc, data = {x:t, y:Hi}
He_name = 'He_' + sc
Hi_name = 'Hi_' + sc
;;;;;;;;;;;;;;;;;;

;;;;;;Poynting flux;;;;;;
S = fltarr(N,3)

Sx = (E[*,1]*B[*,2] - E[*,2]*B[*,1])/mu0
Sy = (E[*,2]*B[*,0] - E[*,0]*B[*,2])/mu0
Sz = (E[*,0]*B[*,1] - E[*,1]*B[*,0])/mu0

S = [[Sx],[Sy],[Sz]]

store_data, 'S_' + sc, data = {x:t, y:S}
S_name = 'S_' + sc
;;;;;;;;;;




;_______________________
;;;;;;;;   J.E   ;;;;;;;
;________________________

;ve1 = 1e3*interp(ve1.y, ve1.x, t)
;vi1 = 1.5*1e3*interp(vi1.y, vi1.x, t)

;e = 1.602e-19    ; Coulombs
;J1 = fltarr(N,3)



  
;--------------------------
;Setting Plot Properties
;--------------------------

;colors = mms_color(['blue', 'green', 'red', 'black'], DECOMPOSED=0)

colors = ['b','g','r']
;;;Ke and Ki;;;
options, Ke_name, 'ytitle', 'Ke !C W/m^2'
options, Ke_name, 'colors', colors[0:2]
options, Ke_name, 'labels', ['x', 'y', 'z']
options, Ke_name, 'labflag', 1

options, Ki_name, 'ytitle', 'Ki !C W/m^2'
options, Ki_name, 'colors', colors[0:2]
options, Ki_name, 'labels', ['x', 'y', 'z']
options, Ki_name, 'labflag', 1


;;;He and Hi;;;
options, He_name, 'ytitle', 'He !C W/m^2'
options, He_name, 'colors', colors[0:2]
options, He_name, 'labels', ['x', 'y', 'z']
options, He_name, 'labflag', 1

options, Hi_name, 'ytitle', 'Hi !C W/m^2'
options, Hi_name, 'colors', colors[0:2]
options, Hi_name, 'labels', ['x', 'y', 'z']
options, Hi_name, 'labflag', 1


;;;Qe and Qi;;;
options, Qe_name, 'ytitle', 'Qe !C W/m^2'
options, Qe_name, 'colors', colors[0:2]
options, Qe_name, 'labels', ['x', 'y', 'z']
options, Qe_name, 'labflag', 1

options, Qi_name, 'ytitle', 'Qi !C W/m^2'
options, Qi_name, 'colors', colors[0:2]
options, Qi_name, 'labels', ['x', 'y', 'z']
options, Qi_name, 'labflag', 1


;;;  S  ;;;
options, S_name, 'ytitle', 'S !C W/m^2'
options, S_name, 'colors', colors[0:2]
options, S_name, 'labels', ['x', 'y', 'z']
options, S_name, 'labflag', 1


;----------------------------------
;Coordinate transformation to LMN
;----------------------------------


;Fill in LMN coordinates and set lmn = 'y' to transform
lmn = strarr(1)
lmn = 'y'
;7/11
L = [0.94822076, -0.25506123, -0.18926481]
M = [0.18182, 0.92451, -0.334996]
N = [0.26042, 0.28324, 0.92301]

;6/17
L = [0.93, 0.3, -0.2]
M = [-0.27, 0.2, -0.94]
N = [-0.24, 0.93, 0.27]

;Just XYZ
;L = [1, 0, 0]
;M = [0, 1, 0]
;N = [0, 0, 1]

;10/16
;L = [0.3665, -0.1201, 0.9226]
;M = [0.5694, -0.7553, -0.3245]
;;N = [0.7358, 0.6443, -0.2084]

;10/31
;L = [0.890, 0.309, -0.335]
;M = [0.333, 0.0627, 0.941]
;N = [0.311, -0.949, -0.0470]

if (lmn eq 'y') then begin
  transf = [[L],[M],[N]]

  Ke_L = Ke[*,0]*L[0] + Ke[*,1]*L[1] + Ke[*,2]*L[2]
  Ke_M = Ke[*,0]*M[0] + Ke[*,1]*M[1] + Ke[*,2]*M[2]
  Ke_N = Ke[*,0]*N[0] + Ke[*,1]*N[1] + Ke[*,2]*N[2]

  Ki_L = Ki[*,0]*L[0] + Ki[*,1]*L[1] + Ki[*,2]*L[2]
  Ki_M = Ki[*,0]*M[0] + Ki[*,1]*M[1] + Ki[*,2]*M[2]
  Ki_N = Ki[*,0]*N[0] + Ki[*,1]*N[1] + Ki[*,2]*N[2]

  He_L = He[*,0]*L[0] + He[*,1]*L[1] + He[*,2]*L[2]
  He_M = He[*,0]*M[0] + He[*,1]*M[1] + He[*,2]*M[2]
  He_N = He[*,0]*N[0] + He[*,1]*N[1] + He[*,2]*N[2]

  Hi_L = Hi[*,0]*L[0] + Hi[*,1]*L[1] + Hi[*,2]*L[2]
  Hi_M = Hi[*,0]*M[0] + Hi[*,1]*M[1] + Hi[*,2]*M[2]
  Hi_N = Hi[*,0]*N[0] + Hi[*,1]*N[1] + Hi[*,2]*N[2]

  Qe_L = Qe[*,0]*L[0] + Qe[*,1]*L[1] + Qe[*,2]*L[2]
  Qe_M = Qe[*,0]*M[0] + Qe[*,1]*M[1] + Qe[*,2]*M[2]
  Qe_N = Qe[*,0]*N[0] + Qe[*,1]*N[1] + Qe[*,2]*N[2]

  Qi_L = Qi[*,0]*L[0] + Qi[*,1]*L[1] + Qi[*,2]*L[2]
  Qi_M = Qi[*,0]*M[0] + Qi[*,1]*M[1] + Qi[*,2]*M[2]
  Qi_N = Qi[*,0]*N[0] + Qi[*,1]*N[1] + Qi[*,2]*N[2]

  S_L = S[*,0]*L[0] + S[*,1]*L[1] + S[*,2]*L[2]
  S_M = S[*,0]*M[0] + S[*,1]*M[1] + S[*,2]*M[2]
  S_N = S[*,0]*N[0] + S[*,1]*N[1] + S[*,2]*N[2]

  Ke_lmn = [[Ke_L],[Ke_M],[Ke_N]]
  Ki_lmn = [[Ki_L],[Ki_M],[Ki_N]]
  He_lmn = [[He_L],[He_M],[He_N]]
  Hi_lmn = [[Hi_L],[Hi_M],[Hi_N]]
  Qe_lmn = [[Qe_L],[Qe_M],[Qe_N]]
  Qi_lmn = [[Qi_L],[Qi_M],[Qi_N]]
  S_lmn = [[S_L],[S_M],[S_N]]

  store_data, 'Ke_lmn_' + sc , data = {x:t, y:1e3*Ke_lmn}
  store_data, 'Ki_lmn_' + sc, data = {x:t, y:1e3*Ki_lmn}
  store_data, 'He_lmn_'+ sc, data = {x:t, y:1e3*He_lmn}
  store_data, 'Hi_lmn_'+ sc, data = {x:t, y:1e3*Hi_lmn}
  store_data, 'Qe_lmn_'+ sc, data = {x:t, y:1e3*Qe_lmn}
  store_data, 'Qi_lmn_'+ sc, data = {x:t, y:1e3*Qi_lmn}
  store_data, 'S_lmn_'+ sc, data = {x:t, y:1e3*S_lmn}

  ;;;Ke and Ki;;;
  options, 'Ke_lmn_' + sc, 'ytitle', 'Ke !C kW/m^2'
  options, 'Ke_lmn_'+ sc, 'colors', colors[0:2]
  options, 'Ke_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'Ke_lmn_'+ sc, 'labflag', 1

  options, 'Ki_lmn_' + sc, 'ytitle', 'Ki !C kW/m^2'
  options, 'Ki_lmn_'+ sc, 'colors', colors[0:2]
  options, 'Ki_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'Ki_lmn_'+ sc, 'labflag', 1


  ;;;He and Hi;;;
  options, 'He_lmn_' + sc, 'ytitle', 'He !C kW/m^2'
  options, 'He_lmn_'+ sc, 'colors', colors[0:2]
  options, 'He_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'He_lmn_'+ sc, 'labflag', 1

  options, 'Hi_lmn_' + sc, 'ytitle', 'Hi !C kW/m^2'
  options, 'Hi_lmn_'+ sc, 'colors', colors[0:2]
  options, 'Hi_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'Hi_lmn_'+ sc, 'labflag', 1




  ;;;Qe and Qi;;;
  options, 'Qe_lmn_' + sc, 'ytitle', 'Qe !C kW/m^2'
  options, 'Qe_lmn_'+ sc, 'colors', colors[0:2]
  options, 'Qe_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'Qe_lmn_'+ sc, 'labflag', 1

  options, 'Qi_lmn_' + sc, 'ytitle', 'Qi !C kW/m^2'
  options, 'Qi_lmn_'+ sc, 'colors', colors[0:2]
  options, 'Qi_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'Qi_lmn_'+ sc, 'labflag', 1



  ;;;  S  ;;;
  options, 'S_lmn_' + sc, 'ytitle', 'S !C kW/m^2'
  options, 'S_lmn_'+ sc, 'colors', colors[0:2]
  options, 'S_lmn_'+ sc, 'labels', ['L', 'M', 'N']
  options, 'S_lmn_'+ sc, 'labflag', 1
endif







;;;;;; ;   Integrated Energy Fluxes   ;  ;;;;;;

;Its helpful to have a qualtitative comparison between over total energy flux

i = 1
N = n_elements(t)

for j = 0,2 do begin
  i=1
  while (i lt N) do begin
    Ke[i,j] = (Ke[i,j] + Ke[i-1,j]);/(t[i]- t[i- 1])
    He[i,j] = (He[i,j] + He[i-1,j]);/(t[i]- t[i- 1])
    Qe[i,j] = (Qe[i,j] + Qe[i-1,j]);/(t[i]- t[i- 1])
    S[i,j] = (S[i,j] + S[i-1,j]);/(t[i]- t[i- 1])
    Ki[i,j] = (Ki[i,j] + Ki[i-1,j]);/(t[i]- t[i- 1])
    Hi[i,j] = (Hi[i,j] + Hi[i-1,j]);/(t[i]- t[i- 1])
    Qi[i,j] = (Qi[i,j] + Qi[i-1,j]);/(t[i]- t[i- 1])
    i = i+1
  endwhile


  Ke[*,j] = Ke[*,j]/(t[N-1] - t[0])
  He[*,j] = He[*,j]/(t[N-1] - t[0])
  Qe[*,j] = Qe[*,j]/(t[N-1] - t[0])
  S[*,j] = S[*,j]/(t[N-1] - t[0])
  Ki[*,j] = Ki[*,j]/(t[N-1] - t[0])
  Hi[*,j] = Hi[*,j]/(t[N-1] - t[0])
  Qi[*,j] = Qi[*,j]/(t[N-1] - t[0])
endfor



names = ['Ke_int_', 'Ki_int_', 'He_int_', 'Hi_int_', 'S_int_']  




store_data, 'Ke_int_' + sc, data = {x:t, y:Ke}
store_data, 'Ki_int_' + sc, data = {x:t, y:Ki}
store_data, 'He_int_' + sc, data = {x:t, y:He}
store_data, 'Hi_int_' + sc, data = {x:t, y:Hi}
store_data, 'Qe_int_' + sc, data = {x:t, y:Qe}
store_data, 'Qi_int_' + sc, data = {x:t, y:Qi}
store_data, 'S_int_' + sc, data = {x:t, y:S}


;;;Ke and Ki;;;
options, 'Ke_int_' + sc, 'ytitle', 'Ke_int !C W/m^2'
options, 'Ke_int_'+ sc, 'colors', colors[0:2]
options, 'Ke_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'Ke_int_'+ sc, 'labflag', 1

options, 'Ki_int_' + sc, 'ytitle', 'Ki_int !C W/m^2'
options, 'Ki_int_'+ sc, 'colors', colors[0:2]
options, 'Ki_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'Ki_int_'+ sc, 'labflag', 1



;;;He and Hi;;;
options, 'He_int_' + sc, 'ytitle', 'He_int !C W/m^2'
options, 'He_int_'+ sc, 'colors', colors[0:2]
options, 'He_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'He_int_'+ sc, 'labflag', 1

options, 'Hi_int_' + sc, 'ytitle', 'Hi_int !C W/m^2'
options, 'Hi_int_'+ sc, 'colors', colors[0:2]
options, 'Hi_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'Hi_int_'+ sc, 'labflag', 1




;;;Qe and Qi;;;
options, 'Qe_int_' + sc, 'ytitle', 'Qe_int !C W/m^2'
options, 'Qe_int_'+ sc, 'colors', colors[0:2]
options, 'Qe_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'Qe_int_'+ sc, 'labflag', 1

options, 'Qi_int_' + sc, 'ytitle', 'Qi_int !C W/m^2'
options, 'Qi_int_'+ sc, 'colors', colors[0:2]
options, 'Qi_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'Qi_int_'+ sc, 'labflag', 1



;;;  S  ;;;
options, 'S_int_' + sc, 'ytitle', 'S_int !C W/m^2'
options, 'S_int_'+ sc, 'colors', colors[0:2]
options, 'S_int_'+ sc, 'labels', ['X', 'Y', 'Z']
options, 'S_int_'+ sc, 'labflag', 1






;;; extra stuff ;;

options, names + sc, 'charsize', 1.5
options, names + sc, 'labsize', 1.5
options, names + sc, 'charthick',2
options, names + sc, 'thick', 2


;;;Calculating angle from L ;;;

get_data, 'Ke_lmn_' + sc, data = Ke_vecs
get_data, 'He_lmn_' + sc, data = He_vecs
get_data, 'S_lmn_' + sc, data = S_vecs

;Angle from L axis 
Ke_LMang = fltarr(n_elements(t))
He_LMang = fltarr(n_elements(t))
S_LMang = fltarr(n_elements(t))

Ke_LNang = fltarr(n_elements(t))
He_LNang = fltarr(n_elements(t))
S_LNang = fltarr(n_elements(t))

for i = 0, n_elements(t)-1 do begin
  Ke_LMang[i] = 180/!pi*atan(Ke_vecs.y[i,1]/Ke_vecs.y[i,0])
  He_LMang[i] = 180/!pi*atan(He_vecs.y[i,1]/He_vecs.y[i,0])
  S_LMang[i] = 180/!pi*atan(S_vecs.y[i,1]/S_vecs.y[i,0])
  Ke_LNang[i] = 180/!pi*atan(Ke_vecs.y[i,2]/Ke_vecs.y[i,0])
  He_LNang[i] = 180/!pi*atan(He_vecs.y[i,2]/He_vecs.y[i,0])
  S_LNang[i] = 180/!pi*atan(S_vecs.y[i,2]/S_vecs.y[i,0])
endfor



int = (0.3)*n_elements(t)/15
;int = (0.0)*128
if (int ne 0) then begin
  Ke_LMang = smooth(Ke_LMang,int)
  He_LMang = smooth(He_LMang,int)
  S_LMang = smooth(S_LMang,int)
  
  Ke_LNang = smooth(Ke_LNang,int)
  He_LNang = smooth(He_LNang,int)
  S_LNang = smooth(S_LNang,int)
  
endif
  


store_data, 'Ke_LM_ang', data = {x:t, y:Ke_LMang}
store_data, 'He_LM_ang', data = {x:t, y:He_LMang}
store_data, 'S_LM_ang', data = {x:t, y:S_LMang}

store_data, 'Ke_LN_ang', data = {x:t, y:Ke_LNang}
store_data, 'He_LN_ang', data = {x:t, y:He_LNang}
store_data, 'S_LN_ang', data = {x:t, y:S_LNang}


;;;MAKE mag and Plasma energy density routines!!!!;;;;










end
