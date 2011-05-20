within MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium;
function dynamicViscosityGasPhase "Viscosity of liquid phase"
//  extends dynamicViscosity; Warum funzt das nicht? Er sagt "multiple algorithms"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "thermodynamic state record";
  output DynamicViscosity eta "Dynamic viscosity";
protected
  Modelica.SIunits.Pressure p_sat =  min(state.p,saturationPressure(state.T, {1}));
  ThermodynamicState state_g=state "gaseous state";
algorithm
  state_g.d:=state.d_g;
  state_g.p:=p_sat;
  eta := dynamicViscosity(state_g);
//  eta := Modelica.Media.Water.IF97_Utilities.dynamicViscosity(state.d_g, state.T, p_sat, 1);
end dynamicViscosityGasPhase;
