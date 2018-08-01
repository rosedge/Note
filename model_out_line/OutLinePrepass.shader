
Shader "ApcShader/OutlinePrePass"
{
	//����ɫ��	
	SubShader
	{
		//���ʹ������Pass����һ��pass�ط��߼���һ�㣬ֻ�����ߵ���ɫ
	Pass
	{
		CGPROGRAM
		#include "UnityCG.cginc"
		fixed4 _OutlineCol;

		struct v2f
		{
			float4 pos : SV_POSITION;
		};

		v2f vert(appdata_full v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			//���Passֱ����������ɫ
			return _OutlineCol;
		}

			//ʹ��vert������frag����
		#pragma vertex vert
		#pragma fragment frag
		ENDCG
		}
	}
}
