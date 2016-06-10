(******************************************************************************
 *   LomCN Mir3 Spanish Game Language LGU File 2013                           *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.6                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 game spanish language strings.                         *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-05] Elamo : first init                                 *
 *  - 0.0.0.2 [2013-04-06] Ashran : translated, needs in-game checking!       *
 *  - 0.0.0.3 [2013-04-05] Coly : fix and clean up file                       *
 *  - 0.0.0.4 [2013-04-07] Ashran : fix according to in-game check            *
 *  - 0.0.0.5 [2013-04-13] Coly : add utf8 code support                       *
 *  - 0.0.0.6 [2013-05-02] 1PKRyan : code clean-up                            *
 *                                                                            *
 ******************************************************************************
 * :Info:                                                                     *
 * The Maximum of String Literale is 255 so you need to add ' + '             *
 * at the end of 255 Char...                                                  *
 * The String it self can have a length of 1024                               *
 *                                                                            *
 * !! Don't localize or delete things with "¦" !!                             *
 * !! it is part of the Script Engine Commands !!                             *
 *                                                                            *
 * !!! Attention, only the Spanish language files are                         *
 * !!! matched by the development team, not other languages??.                *
 *                                                                            *
 ******************************************************************************)

unit mir3_language_game;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes;

function GetGameLine(): Integer; stdcall;
function GetGameString(ID: Integer; Buffer: PWideChar): Integer; stdcall;

implementation

function GetGameLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetGameString(ID: Integer; Buffer: PWideChar): Integer; stdcall;
var
  Value : WideString;
begin
  case ID of
    (*******************************************************************
    *                     Login, Server Selection.                     *
    *******************************************************************)
    1 : Value := 'Entrar';                                                              // Button
    2 : Value := 'Salir';                                                               // Button
    3 : Value := 'Nueva cuenta';                                                        // Button URL
    4 : Value := 'Cambiar contraseña';                                                  // Button URL
    5 : Value := 'ID                                CONTRASEÑA¦CE¦';              // Button
    6 : Value := 'Entrar (L)';                                                          // [1] Hint
    7 : Value := 'Salir (X)';                                                           // [2] Hint
    8 : Value := 'Nueva cuenta (N)';                                                    // [3] Hint
    9 : Value := 'Cambiar contraseña (P)';                                              // [4] Hint
    10: Value := 'Has sido desconectado.';                                              // Infoboard
    11: Value := 'El servidor está\desconectado por mantenimiento.';                    // Infoboard
    12: Value := 'No se puede conectar al servidor.\El servidor es inalcanzable.';      // Infoboard
    13: Value := '¿Seguro que quieres salir?';
    14: Value := 'Reservado';
    15: Value := 'Reservado';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'Tu ID o contraseña son incorrectos.\Inténtalo otra vez.';
    17: Value := 'Has introducido datos\erróneos tres veces.\Inténtalo más tarde.';
    18: Value := 'No se puede acceder a la información de la cuenta.\Inténtalo otra vez.';
    19: Value := 'Tu cuenta ha sido deshabilitada.\Visita www.lomcn.org\para más detalles.';
    20: Value := 'Tu subscripción ha caducado.\Visita www.lomcn.org\para más detalles.';
    21: Value := '¡Han ocurrido errores desconocidos!\Visita www.lomcn.org\para más detalles.';
    22: Value := 'Reservado';
    23: Value := 'Reservado';
    24: Value := 'Reservado';
    25: Value := 'Reservado';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := '¡Tu subscripción caduca hoy!\Visita http://www.lomcn.org\para más detalles.';
    27: Value := 'Tu subscripción caducará en\ %d días.';
    28: Value := 'El acceso de tu IP será válido por\otros %d días.';
    29: Value := '¡El acceso de tu IP caduca hoy!';
    30: Value := 'El acceso de tu IP será válido por\otras %d horas.';
    31: Value := 'Tu ID será válido por otras\ %d horas.';
    32: Value := 'Reservado';
    33: Value := 'Reservado';
    34: Value := 'Reservado';
    35: Value := 'Reservado';
    36: Value := 'Reservado';
    37: Value := 'Reservado';
    38: Value := 'Reservado';
    39: Value := 'Reservado';
    40: Value := 'Reservado';
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
    41: Value := 'Cargando la información de los personajes. Por favor, espera.';
    42: Value := 'Seleccionar Guerrero';
    43: Value := 'Seleccionar Mago';
    44: Value := 'Seleccionar Taoísta';
    45: Value := 'Seleccionar Asesino';
    46: Value := 'Confirmar';
    47: Value := 'Cancelar';
    48: Value := 'Nombre';
    49: Value := 'Nivel';
    50: Value := 'Clase';
    51: Value := 'Oro';
    52: Value := 'Exp.';
    53: Value := 'Reservado';
    54: Value := 'Reservado';
    55: Value := 'Hombre';
    56: Value := 'Mujer';
    57: Value := 'Guerrero';
    58: Value := 'Mago';
    59: Value := 'Taoísta';
    60: Value := 'Asesino';
    { Information about Warriors }
    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Guerrero]¦CE¦\¦Y08¦'             // SE: Better to have gender first
               + ' Los Guerreros son excelentes en ataque cuerpo a cuerpo debido a su poder y\'
               + ' resistencia. Éstos pueden aprender varios estilos de artes marciales: desde\'
               + ' el básico Swordmanship al poderoso BladeStorm. Llegan a ser realmente\'
               + ' formidables cuando unen todos sus poderes, aunque son débiles si son\'
               + ' atacados a distancia. Son fáciles de manejar y consiguen subir antes\'
               + ' de nivel al principio.\';
    { Information about Wizards }
    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Mago]¦CE¦\¦Y08¦'
               + ' Los Magos pueden lanzar variados hechizos, por lo que son interesantes y\'
               + ' divertidos. Son buenos en combate a distancia pero muy limitados en combate\'
               + ' cuerpo a cuerpo debido a su debilidad física. En niveles superiores pueden\'
               + ' ser muy poderosos con sus fantásticas artes, aunque deben estar en todo\'
               + ' momento atentos a su cantidad de vida, por lo que su manejo es complicado\'
               + ' en sus inicios.\';
    { Information about Taoists }
    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoísta]¦CE¦\¦Y08¦'
               + ' Los Taoístas tienen habilidades físicas y espirituales. Estudian la vida y\'
               + ' la muerte, así que tienen grandes conocimientos de medicina y técnicas de\'
               + ' apoyo a las demás clases. Sus primeras técnicas son la curación y el uso de\'
               + ' distintos tipos de veneno. Los usuarios inexpertos tardarán en aprender su\'
               + ' funcionamiento al tener que usar diferentes objetos especiales, pero llegan\'
               + ' a convertirse en personajes indispensables para los demás.\';
    { Information about Assassins }
    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Asesino]¦CE¦\¦Y08¦'
               + '¦C1D1AD69¦¦C2C19D59¦ Los Asesinos son miembros de una organización secreta y su historia es\'
               + ' relativamente desconocida. Son débiles físicamente, pero pueden esconderse\'
               + ' y realizar ataques mientras los demás no pueden verlos. También son\'
               + ' excelentes en matar rápidamente. Sin embargo tienen que ir con mucho\'
               + ' cuidado a no encontrarse con múltiples adversarios, ya que tienen menos\'
               + ' técnicas defensivas que los otros personajes. Los Asesinos son recomendados\'
               + ' para jugadores experimentados, porque necesitan movimientos ágiles,\'
               + ' astucia en las decisiones y pensamiento rápido.\';
    65: Value := 'Personaje borrado.';
    66: Value := 'Los personajes borrados no pueden ser\'
               + 'recuperados y no podrás crear otro\'
               + 'personaje con el mismo nombre por un\'
               + 'tiempo. Si quieres continuar, introduce\'
               + 'tu contraseña a continuación.';
    67: Value := 'No puedes crear más de %d personajes.';
    68: Value := 'Debes crear un personaje antes.';
    69: Value := 'No se pudo acceder a la información de los personajes.';
    70: Value := 'Ya existe un personaje con este nombre.';
    71: Value := 'No puedes crear otro personaje.';
    72: Value := 'Error en la creación de personajes - código 4';
    73: Value := 'Han ocurrido errores desconocidos.\Visita www.lomcn.org\para más detalles.';
    74: Value := 'Ha habido un error borrando\tu personaje.';
    75: Value := 'Jugar¦CE¦';
    76: Value := 'Nuevo personaje¦CE¦';
    77: Value := 'Borrar personaje¦CE¦';
    78: Value := 'Salir¦CE¦';
    79: Value := 'Reservado';
    80: Value := 'Reservado';
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
    81: Value := 'Opciones';
    82: Value := 'Chat';
    83: Value := 'Mail';
    84: Value := 'Grupo';
    85: Value := 'Clan';
    86: Value := 'Avatar';
    87: Value := 'Asedio';
    88: Value := 'Auto';
    89: Value := 'Salir';
    90: Value := 'Cerrar';
    91..100 : Value := 'Reservado';
    {Game Settings}
    101: Value := 'General';
    102: Value := 'Permisos';
    103: Value := 'Chat';
    104: Value := 'Imagen';
    { Page 1 Basic }
    105: Value := 'Modo de ataque (Todos)';
    106: Value := 'Modo de ataque (Pacífico)';
    107: Value := 'Modo de ataque (Pareja)'; //(Dear)'; - Lover, Partner, Spouse, Couple, Marriage
    108: Value := 'Modo de ataque (Maestro)';
    109: Value := 'Modo de ataque (Grupo)';
    110: Value := 'Modo de ataque (Clan)';
    111: Value := 'Modo de ataque (Asesinos)';
    112: Value := 'Reserved';
    113: Value := 'Reserved';
    114: Value := 'Cambiar modo de ataque';                   // Hint for Attack Mode
    116: Value := 'Modo de ataque normal';
    117: Value := 'Cambiar modo de ataque';                   // Hint for Attack Mode
    118: Value := 'Música de fondo';
    119: Value := '[ Música de fondo: On/Off ]';            // Hint Background Music
    120: Value := 'Efectos de sonido';
    121: Value := '[ Efectos de sonido: On/Off ]';               // Hint Sound Effects
    122: Value := 'Sonido direccional (stereo)';
    123: Value := '[ Sonido direccional: On/Off ]';           // Hint Sound Effects
    124: Value := 'Auto-recoger objetos';
    125: Value := '[ Auto-recoger objetos: On/Off ]';           // Hint Sound Effects
    126: Value := 'Mostrar nombre de drops';
    127: Value := '[ Mostrar nombre de drops: On/Off ]'; // Hint Sound Effects
    { Page 2 Permissions }
    128: Value := 'Permitir unión a grupo';
    129: Value := '[ Permitir unión a grupo: On/Off ]';
    130: Value := 'Permitir unión a clan';
    131: Value := '[ Permitir unión a clan: On/Off ]';
    132: Value := 'Permitir resurrección';
    133: Value := '[ Permitir resurrección: On/Off ]';
    134: Value := 'Permitir recall';
    135: Value := '[ Permitir recall: On/Off ]';
    136: Value := 'Permitir comercio';
    137: Value := '[ Permitir comercio: On/Off ]';
    138: Value := 'Mostrar sangre (18+)'; // Fixed
    139: Value := '[ Mostrar sangre: On/Off ]';
    140: Value := 'Reserved';
    141: Value := 'hint reserved';
    142: Value := 'Reserved';
    143: Value := 'hint reserved';
    144: Value := 'Reserved';
    145: Value := 'hint reserved';
    146: Value := 'Reserved';
    147: Value := 'hint reserved';
    { Page 3 Chatting }
    148: Value := 'Permitir mensajes privados';
    149: Value := '[ Permitir mensajes privados: On/Off ]';
    150: Value := 'Permitir grito';
    151: Value := '[ Permitir grito: On/Off ]';
    152: Value := 'Reserved';
    153: Value := 'hint reserved';
    154: Value := 'Permitir mensajes de clan';
    155: Value := '[ Permitir mensajes de clan: On/Off ]';
    156: Value := 'Bloquear privados de un jugador';
    157: Value := '[ Privados de un jugador bloqueados ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
    158: Value := 'Reserved';
    159: Value := 'Reserved';
    160: Value := 'hint reserved';
    161: Value := 'Reserved';
    162: Value := 'hint reserved';
    163: Value := 'Reserved';
    164: Value := 'hint reserved';
    165: Value := 'Reserved';
    166: Value := 'hint reserved';
    167: Value := 'Reserved';
    168: Value := 'hint reserved';
    { Page 4 Visual }
    169: Value := 'Mostrar daño';
    170: Value := '[ Mostrar daño: On/Off ]';
    171: Value := 'Mostrar efectos de magias';
    172: Value := '[ Mostrar efectos de magias: On/Off ]';
    173: Value := 'Mejorar sombras';
    174: Value := '[ Mejorar sombras: On/Off ]';
    175: Value := 'Mostrar casco';
    176: Value := '[ Mostrar casco: On/Off ]';
    177: Value := 'Mostrar efectos de criaturas';
    178: Value := '[ Mostrar efectos de criaturas: On/Off ]';
    179: Value := 'Mostrar cabello teñido';
    180: Value := '[ Mostrar cabello teñido: On/Off ]';
    181: Value := 'Mostrar avatar';
    182: Value := '[ Avatar: On/Off ]';
    183: Value := 'Mostrar criaturas en minimapa';  
    184: Value := '[ Mostrar criaturas en minimapa: On/Off ]';
    185: Value := 'Barra HP de los jugadores';
    186: Value := '[ Barra HP de los jugadores: On/Off ]';
    187: Value := 'Barra HP de las critaturas';
    188: Value := '[ Barra HP de las criaturas: On/Off ]';
    189: Value := 'Reservado';
    { Exit Window }
    190: Value := 'Salir';
    191: Value := 'Salir del juego.';
    192: Value := 'Log out';
    193: Value := 'Salir y seleccionar otro personaje.';
    194: Value := '¿Seguro que quieres salir?';
    195: Value := 'Cancelar';
    { Belt Window }
    196: Value := 'Rotar';                             //Hint
    197: Value := 'Cerrar';                            //Hint
    198: Value := 'Reservado';
    199: Value := 'Reservado';
    200: Value := 'Reservado';
    { Mini Map }
    201: Value := '';                                  //Hint
    202: Value := '';                                  //Hint
    203: Value := '';                                  //Hint
    204: Value := '';                                  //Hint
    205: Value := 'Sin minimapa';
    206: Value := '¡No disponible!';
    207: Value := 'Sin usar';
    208..210: Value := 'Reservado';
    { Body Window }
    211: Value := 'Nivel';
    212: Value := 'Experiencia';
    213: Value := 'Puntos de salud (HP)';
    214: Value := 'Puntos de maná (MP)';
    215: Value := 'Peso en bolsa';
    216: Value := 'Peso en cuerpo';
    217: Value := 'Peso en mano';
    218: Value := 'Destreza';
    219: Value := 'Agilidad';
    220: Value := 'E(Att)';
    221: Value := 'E(Adv)';
    222: Value := 'E(Dis)';
    223: Value := 'Ataque con elemento';                   //Hint
    224: Value := 'Defensa a elemento';                    //Hint
    225: Value := 'Debilidad a elemento';                  //Hint
    226: Value := 'Ataque con elemento fuego';             //Hint
    227: Value := 'Defensa a elemento fuego';              //Hint
    228: Value := 'Debilidad a elemento fuego';            //Hint
    229: Value := 'Ataque con elemento hielo';             //Hint
    230: Value := 'Defensa a elemento hielo';              //Hint
    231: Value := 'Debilidad a elemento hielo';            //Hint
    232: Value := 'Ataque con elemento rayo';              //Hint
    233: Value := 'Defensa a elemento rayo';               //Hint
    234: Value := 'Debilidad a elemento rayo';             //Hint
    235: Value := 'Ataque con elemento viento';            //Hint
    236: Value := 'Defensa a elemento viento';             //Hint
    237: Value := 'Debilidad a elemento viento';           //Hint
    238: Value := 'Ataque con elemento sagrado';           //Hint
    239: Value := 'Defensa a elemento sagrado';            //Hint
    240: Value := 'Debilidad a elemento sagrado';          //Hint
    241: Value := 'Ataque con elemento oscuro';            //Hint
    242: Value := 'Defensa a elemento oscuro';             //Hint
    243: Value := 'Debilidad a elemento oscuro';           //Hint
    244: Value := 'Ataque con elemento ilusión';           //Hint
    245: Value := 'Defensa a elemento ilusión';            //Hint
    246: Value := 'Debilidad a elemento ilusión';          //Hint
    247..250: Value := 'Reservado';
    { Group Window }
    251: Value := 'Grupo';
    252: Value := 'Cerrar';                                //Hint
    253: Value := 'Añadir miembro';                        //Hint
    254: Value := 'Quitar miembro';                        //Hint
    255: Value := 'Crear un grupo';                        //Hint
    256: Value := 'Permitir unión a grupo';                //Hint
    257..260: Value := 'Reservado';
    { Magic Window }
    261: Value := ' Fuego  ';                              //Hint
    262: Value := ' Hielo  ';                              //Hint
    263: Value := ' Rayo  ';                               //Hint
    264: Value := ' Viento  ';                             //Hint
    265: Value := ' Sagrado  ';                            //Hint
    266: Value := ' Oscuro  ';                             //Hint
    267: Value := ' Ilusión  ';                            //Hint
    268: Value := ' Técnicas ';//'Martial Art';            //Hint
    269: Value := 'Cerrar';    //'Close Magic Window';     //Hint
    270: Value := ' Atrocity  ';                           //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Assa  ';                               //Hint - ??
    272: Value := ' Assassinate  ';                        //Hint - ??
    (* Development Strings, not for real play *)
    1050: Value := 'DC 1000-1000';
    1051: Value := 'AC 1000-1000';
    1052: Value := 'BC 1000-1000';
    1053: Value := 'MC 1000-1000';
    1054: Value := 'SC 1000-1000';
    1055: Value := 'MR 1000-1000';
    1056: Value := '+1000';
    1057: Value := '1000/1000';
    1058: Value := '194';
    1059: Value := '3.55 %';
    1060: Value := 'Coly\GameMasterGuild';
    1061: Value := 'Coly´s Spouse';
    1062: Value := '100-100';
    1063: Value := '10000';
    1064: Value := '1000';
    1065: Value := '99';
    1066: Value := '10';
    1067: Value := '+';
    1068: Value := '-';
    1069: Value := 'x';
    1070: Value := '*';

    1071..2000: Value := 'Reservado';
    else Value := 'No soportado';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;

end.