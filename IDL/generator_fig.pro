;;;; Generator Figure ;;;
;


PRO GENERATOR_FIG

;Define which spacecraft to use and constants
probe = '1'


sc  = 'mms' + probe

ec = 1.602e-19    ; Coulombs
mu0 = 1.2566370e-06  ;m kg / C^2
m_e = 9.1093836e-31 ; kg
m_i = 1.6726219e-27 ; kg



;Set timerange and load data 
timespan,'2017-06-17/20:24:00',15 , /Second
;timespan,'2019-04-20/15:32:00',30 , /Second



mms_load_fpi,data_rate = 'brst',probes = probe,/time_clip
;
mms_load_edp,level = 'l2',data_rate = 'brst',probes = probe, /time_clip
mms_load_fgm, level = 'l2',data_rate = 'brst',probes = probe,/time_clip


;Set time variable to fpi burst
get_data, sc + '_des_bulkv_gse_brst', DATA = vel_e
get_data, sc + '_fgm_b_gse_brst_l2_bvec', DATA = bfield
t = vel_e.x
;t = bfield.x






;Getting all necessary base quantities
get_data, sc + '_edp_dce_gse_brst_l2', data = E
get_data, sc + '_fgm_b_gse_brst_l2_bvec', data = B
get_data, sc + '_des_bulkv_gse_brst', data = ve
get_data, sc + '_dis_bulkv_gse_brst', data = vi
get_data, sc + '_des_numberdensity_brst', data = n_e
get_data, sc + '_dis_numberdensity_brst', data = n_i



;;; Define the LMN coordinates and move fields to LMN ;;;;
;6/17/2017
L = [0.93, 0.3, -0.2]
M = [-0.27, 0.2, -0.94]
N = [-0.24, 0.93, 0.27]

;L = [1,0,0]
;M = [0,1,0]
;N = [0,0,1]

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

get_data, 'E', data = E
get_data, 'Ve', data = ve
get_data, 'Vi', data = vi




E = 1e-3*interp(E.y, E.x, t)
ve = 1e3*interp(ve.y, ve.x, t)
vi = 1e3*interp(vi.y, vi.x, t)
n_e = 1e6*interp(n_e.y, n_e.x, t)


;stop

;;; Current Density ;;;;
ec = 1.602e-19    ; Coulombs
N = n_elements(t)
J = fltarr(n_elements(t),3)
for i=0,2 do begin
  J[*,i] = ec*n_e*(vi[*,i] - ve[*,i])
endfor


store_data, 'J.E_Comps', data = {x:t, y: 1e9*[[J[*,0]*E[*,0]],[J[*,1]*E[*,1]],[J[*,2]*E[*,2]]]} ;nW/m^3
store_data, 'J.E_Total', data = {x:t, y: 1e9*[J[*,0]*E[*,0]+J[*,1]*E[*,1]+J[*,2]*E[*,2]]}


names = ['B','E','J.E_Comps', 'Ke_lmn_' + sc,'He_lmn_' + sc, 'S_lmn_' + sc ]

options, names, 'colors', ['b','g','r']
options, names, 'labels', ['L','M','N']
options, names, 'labflag', 1
options, names, 'charsize', 1.5
options, names, 'labsize', 1.5
options, names, 'charthick',2
options, names, 'thick', 2

options, 'J.E_Total', 'charsize', 1.5
options, 'J.E_Total', 'labsize', 1.5
options, 'J.E_Total', 'charthick',2
options, 'J.E_Total', 'thick', 2

other = [sc + '_des_pitchangdist_lowen_brst', sc + '_des_pitchangdist_highen_brst','J.E_Total']

options, other, 'charsize', 1.5
options, other, 'labsize', 1.5
options, other, 'charthick',2
options, other, 'thick', 2

tplot, [names, other]








end