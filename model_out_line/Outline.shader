/******************************************************************************
* DESCRIPTION: 轮廓描边（基于法线扩展模型）
*
*     Copyright (c) 2017, 谭伟俊 (TanWeijun)
*     All rights reserved
*
* COMPANY: Metek
* CREATED: 2017.08.15, 11:47, CST
*******************************************************************************/

Shader "Metek/Outline"
{
	Properties
	{
		_OutlineColor ("Outline color", Color) = (1.0, 1.0, 0.0, 1.0)
		_OutlineWidth ("Outline width", Range(0.002, 0.03)) = 0.005
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Name "OUTLINE"

			Cull Front
			ZWrite On
			ColorMask RGB

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			half _OutlineWidth;			
			v2f vert (appdata v)
			{
				v2f o;

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				float3 normalV = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(normalV.xy);

			#ifdef UNITY_Z_0_FAR_FROM_CLIPSPACE		// to handle recent standard asset package on older version of unity (before 5.5)
				o.vertex.xy += offset * UNITY_Z_0_FAR_FROM_CLIPSPACE(o.vertex.z) * _OutlineWidth;
			#else
				o.vertex.xy += offset * o.vertex.z * _OutlineWidth;
			#endif

				return o;
			}
			
			fixed4 _OutlineColor;
			fixed4 frag (v2f i) : SV_Target
			{
				return _OutlineColor;
			}
			ENDCG
		}
	}
}
