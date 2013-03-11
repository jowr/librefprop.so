#pyrp - Python and Refprop interface
Provides access to most Refprop functions from Python.

##Basic Information
The file python code is based on Bruce Wernicks REFPROP8 library that 
can be downloaded from [NIST](http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.htm#PythonApplications). 
Original copyright information: 
REFPROP8 library, Bruce Wernick, info@coolit.co.za, Last updated: 6 August 2010

Very basic unit tests are included in `test_SI.py`. This file originates from the 
[PyRef](http://code.google.com/p/pyref/) project as well as some of the functions I use in this module.

The few changes I made to the file are mostly related to the new function
names created by the Gnu Compiler. I also added a class that uses SI units and takes 
mass fractions as standard input. 

Keep in mind that Refprop uses the units given below and that you might want to add
your own conversion routines in case you use the standard class. You can also enter a new path to fluid and 
mixture definition files in line 350 of `refpropClass.py`. 

Enjoy working with this small python package!

Jorrit Wronski, 
jowr@mek.dtu.dk


| Property                     | Refprop       | RefpropSI     |
|------------------------------|---------------|---------------|
| temperature                  | K             | K             |
| pressure, fugacity           | kPa           | Pa            |
| density                      | mol/L         | kg/m3         |
| composition                  | mole fraction | mass fraction |
| quality                      | mole basis    | mass based    |
| enthalpy, internal energy    | J/mol         | J/kg          |
| Gibbs, Helmholtz free energy | J/mol         | J/kg          |
| entropy, heat capacity       | J/(mol-K)     | J/(kg-K)      |
| speed of sound               | m/s           | m/s           |
| Joule-Thompson coefficient   | K/kPa         | K/pa          |
| d(p)/d(rho)                  | kPa-L/mol     |      |
| d2(p)/d(rho)2                | kPa-(L/mol)2  |      |
| viscosity                    | uPa-s         |      |
| thermal conductivity         | W/(m-K)       |      |
| dipole moment                | debye         |      |
| surface tension              | N/m           |      |


## Example
The included `example.py` should produce the follwing output:

      Point       Temperature,    Pressure,      Enthalpy,       Entropy,   
                        C             bar           kJ/kg         kJ/kg-K    
    ========================================================================
    Point 1              20.000          1.638        105.738          0.612 
    Point 2              24.117         40.000        118.551          0.633 
    Point 3             250.000         39.500        912.754          2.558 
    Point 4             177.568          2.138        791.765          2.649 


         Parameter         Value     Unit  
    =====================================
    subcooling              5.000   K     
    HX pressure drop        0.500   bar   
    eta pump               50.000   %     
    eta expander           75.000   %     
    Pump work              12.813   kJ/kg 
    added heat            794.203   kJ/kg 
    expander work        -120.989   kJ/kg 
    thermal efficiency     13.621   %     
    power, 50 g/s           5.409   kW  