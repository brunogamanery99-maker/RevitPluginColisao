using System;
using Autodesk.Revit.UI;
using Autodesk.Revit.UI.Events;

namespace RevitPluginColisao
{
    public class App : IExternalApplication
    {
        public Result OnStartup(UIControlledApplication application)
        {
            try
            {
                // Registra o comando no Revit
                TaskDialog.Show("Revit Plugin", "Detecção de Colisão carregado com sucesso!");
                return Result.Succeeded;
            }
            catch (Exception ex)
            {
                TaskDialog.Show("Erro", $"Falha ao carregar plugin: {ex.Message}");
                return Result.Failed;
            }
        }

        public Result OnShutdown(UIControlledApplication application)
        {
            return Result.Succeeded;
        }
    }
}
