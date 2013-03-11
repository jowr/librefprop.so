'''
Just a small example on how to use the Refprop class to calculate a power cycle.
This file employs a working fluid mixture at supercritical conditions.
'''
from texttable import Texttable
# Define output routines for pretty-printing
pointsTable = Texttable()
pointsTable.set_deco(Texttable.HEADER)
pointsTable.set_chars(['-', '|', '+', '='])
pointsTable.set_cols_dtype(['t',  # text
                      'f',  # float (decimal) 
                      'f',  # float (decimal) 
                      'f',  # float (decimal) 
                      'f']) # float (decimal)
pointsTable.set_cols_align(["l", "r", "r", "r", "r"])
pointsTable.set_cols_valign(["t", "m", "m", "m", "m"])
#pointsTable.set_cols_width([10, 12, 13, 13, 13])
pointsTable.header(["Point","Temperature, C","Pressure, bar","Enthalpy, kJ/kg","Entropy, kJ/kg-K"])

# Define output routines for pretty-printing
paramsTable = Texttable()
paramsTable.set_deco(Texttable.HEADER)
paramsTable.set_chars(['-', '|', '+', '='])
paramsTable.set_cols_dtype(['t',  # text
                      'f',  # float (decimal)  
                      't']) # text
paramsTable.set_cols_align(["l", "r", "l"])
paramsTable.set_cols_valign(["t", "m", "m"])
#paramsTable.set_cols_width([20, 15, 15])
paramsTable.header(["Parameter","Value","Unit"])


from pyrp.refpropClasses import RefpropSI
RP = RefpropSI()
RP.SETUPFLEX(xkg=[0.5,0.5], FluidNames="butane|pentane")

def bar(p):
    return p * 1e5

def Pa(p):
    return p / 1e5

def C(T):
    return T+273.15

def K(T):
    return T-273.15

def kilo(e):
    return e * 1000.

def milli(e):
    return e / 1000.

# Define basic parameters
deltaP = bar(0.5)
deltaT = 5.
paramsTable.add_row(["subcooling",deltaT,"K"])
paramsTable.add_row(["HX pressure drop",Pa(deltaP),"bar"])

eta_pump = 0.50
eta_expa = 0.75
paramsTable.add_row(["eta pump",eta_pump*100,"%"])
paramsTable.add_row(["eta expander",eta_expa*100,"%"])

# Condensed liquid with a subcooling of 5 deg C
T_1 = C(20)
T, p_1, Dl, Dv = RP.SATT(T_1+deltaT,kph=1)
T_1,p_1,D_1,Dl_1,Dv_1,q_1,e_1,h_1,s_1,cv_1,cp_1,w_1 = RP.TPFLSH(T_1,p_1)
pointsTable.add_row(["Point 1",K(T_1),Pa(p_1),milli(h_1),milli(s_1)])

# Pumping to a high pressure
p_2 = bar(40)
T_2s,p_2s,D_2s,Dl_2s,Dv_2s,q_2s,e_2s,h_2s,s_2s,cv_2s,cp_2s,w_2s = RP.PSFLSH(p_2,s_1)

h_2 = (h_2s - h_1) / eta_pump + h_1
T_2,p_2,D_2,Dl_2,Dv_2,q_2,e_2,h_2,s_2,cv_2,cp_2,w_2 = RP.PHFLSH(p_2,h_2)
pointsTable.add_row(["Point 2",K(T_2),Pa(p_2),milli(h_2),milli(s_2)])

pump_work = h_2 -h_1
paramsTable.add_row(["Pump work",milli(pump_work),"kJ/kg"])

# Adding heat to reach specified conditions
T_3 = C(250)
p_3 = p_2 - deltaP
T_3,p_3,D_3,Dl_3,Dv_3,q_3,e_3,h_3,s_3,cv_3,cp_3,w_3 = RP.TPFLSH(T_3,p_3)
pointsTable.add_row(["Point 3",K(T_3),Pa(p_3),milli(h_3),milli(s_3)])

heat_added = h_3 - h_2
paramsTable.add_row(["added heat",milli(heat_added),"kJ/kg"])

# Expanding the mixture
p_4 = p_1 + deltaP
T_4s,p_4s,D_4s,Dl_4s,Dv_4s,q_4s,e_4s,h_4s,s_4s,cv_4s,cp_4s,w_4s = RP.PSFLSH(p_4,s_3)

h_4 = eta_expa * (h_4s - h_3) + h_3
T_4,p_4,D_4,Dl_4,Dv_4,q_4,e_4,h_4,s_4,cv_4,cp_4,w_4 = RP.PHFLSH(p_4,h_4)
pointsTable.add_row(["Point 4",K(T_4),Pa(p_4),milli(h_4),milli(s_4)])

expander_work = h_4 -h_3
paramsTable.add_row(["expander work",milli(expander_work),"kJ/kg"])

# Cycle properties:
eta_th = (expander_work+pump_work)*-1. / heat_added
paramsTable.add_row(["thermal efficiency",eta_th*100,"%"])

power = eta_th * milli(heat_added) * 0.050 
paramsTable.add_row(["power, 50 g/s",power,"kW"])

print "\n" + pointsTable.draw() + "\n"
print "\n" + paramsTable.draw() + "\n"