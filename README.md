# Approximate 8-bit ALU

## Descripción
Diseño de ALU configurable con modos exactos y aproximados. Implementa suma con ignorancia de acarreo entre nibbles y multiplicación con truncamiento de bits menos significativos. Incluye bandera de error para monitoreo de calidad en tiempo de ejecución.

## Mapa de Pines
| Señal | Bits | Función |
|-------|------|---------|
| ui_in | 7:0 | Operando A |
| uio   | 3:0 | Operando B |
| uio   | 6:4 | Código de operación (0-7) |
| uio   | 7   | Habilitación de modo aproximado |
| uo_out| 6:0 | Resultado |
| uo_out| 7   | Bandera de error |

## Licencia
CERN-OHL-S-2.0
