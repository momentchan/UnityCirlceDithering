using UnityEngine;

[ExecuteInEditMode]
public class CircleDitheringEffect : MonoBehaviour
{
    [SerializeField] private Material mat;
    [SerializeField] EffectSource source;
    [SerializeField] private Texture texture;
    [SerializeField] private bool color;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        mat.SetFloat("_ColorMode", color ? 1 : 0);

        if (source == EffectSource.Scene)
            Graphics.Blit(src, dest, mat);
        else
            Graphics.Blit(texture, dest, mat);
    }

    public enum EffectSource
    {
        Scene, Webcam
    }
}
