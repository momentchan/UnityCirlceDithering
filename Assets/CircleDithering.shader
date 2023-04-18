Shader "Unlit/CircleDithering"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Density("Density", float) = 8
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Density;
            float _ColorMode;

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed4 col = 1;
                float2 U = i.uv * _ScreenParams.xy;

                for (int k=0; k<289; k++) {
                    float2 P = ceil( U/4.0 + float2(k%17,k/17) - 9. ); 
                    
                    P += frac( 1e4* sin( mul( float2x2(12.1,-37.4,-17.3,31.7), P) )) - 0.5;
                    P *= 4.0;

                    float v = tex2D(_MainTex, P /_ScreenParams.xy).r ,                     
                          r = 2.+30.*v;    
                    if(frac( 1e4* sin( dot(P,float2(12.1,31.7))  )) * r/_Density < 1.-v)
                        col -= .2 * smoothstep(1.5,0.,abs( length(P-U) - r ));
                }
                return lerp(col, (1-col) * tex2D(_MainTex, i.uv), _ColorMode);
            }
            ENDCG
        }
    }
}
