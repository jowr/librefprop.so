within MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium;
function dynamicViscosityLiquidPhase "Viscosity of liquid phase"
//  extends dynamicViscosity; Warum funzt das nicht? Er sagt "multiple algorithms"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "thermodynamic state record";
  output DynamicViscosity eta "Dynamic viscosity";
protected
  Modelica.SIunits.Pressure p_sat =  max(state.p,saturationPressure(state.T, {1}));
  ThermodynamicState state_l=state "liquid state";
algorithm
  state_l.d:=state.d_l;
  state_l.p:=p_sat;
  eta := dynamicViscosity(state_l);
//  eta := Modelica.Media.Water.IF97_Utilities.dynamicViscosity(state.d_l, state.T, p_sat, 1);
//  Modelica.Utilities.Streams.print(String(p_sat));
end dynamicViscosityLiquidPhase;
