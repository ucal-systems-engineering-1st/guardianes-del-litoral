1. Introducción
El presente documento describe de manera detallada el análisis, diseño y planificación del
videojuego educativo Guardianes del Litoral Peruano. Este proyecto nace de la necesidad de
innovar en la enseñanza de ciencias ambientales, ofreciendo una experiencia interactiva que
permita a los estudiantes explorar, investigar y tomar decisiones con impacto real sobre los
ecosistemas del litoral peruano.
A diferencia de los métodos tradicionales de enseñanza, este videojuego propone un
modelo de aprendizaje activo basado en narrativa inmersiva, resolución de problemas y
consecuencias tangibles de las decisiones tomadas. El jugador asume el rol de un investigador
científico que recorre distintas zonas del litoral peruano, descubriendo la riqueza y
vulnerabilidad de sus ecosistemas.El proyecto integra conceptos de programación modular en
GDScript, diseño de experiencia de usuario (UX), manejo de datos en JSON y principios
pedagógicos de aprendizaje basado en juegos (Game-Based Learning o GBL).
2. Planteamiento del Problema
2.1 Contexto Educativo
En la actualidad, la enseñanza de temas medioambientales en educación básica y universitaria
enfrenta desafíos significativos. Los estudiantes muestran dificultades para conectar conceptos
abstractos como biodiversidad, impacto ambiental o cadenas tróficas con situaciones reales.
Esto genera desinterés, aprendizaje superficial y poca retención a largo plazo.
2.2 Problemas Identificados
Tabla 1 Problemas educativos identificados en la enseñanza de temas ambientales
Área Problemática Descripción
Biodiversidad Marina Los estudiantes no logran distinguir ni valorar las
especies endémicas del litoral peruano ni sus roles
en el ecosistema.
Problemas Ambientales La contaminación, la pesca ilegal y el cambio
climático son tratados como temas abstractos sin
conexión con la realidad local.
Impacto Humano Se subestima la influencia de las actividades
cotidianas y económicas sobre el equilibrio del
ecosistema costero.
Nota: Describe las principales dificultades pedagógicas que enfrentan los estudiantes al
asimilar conceptos medioambientales mediante las metodologías de enseñanza tradicionales.
2.3 Limitaciones del Método Tradicional
• Metodologías centradas en la memorización pasiva de datos.
• Escasa estimulación del pensamiento crítico y analítico.
• Falta de simulaciones que permitan experimentar consecuencias de decisiones.
• Baja motivación intrínseca del estudiante ante contenidos estáticos.
• Desconexión entre la teoría y el contexto geográfico y cultural peruano.
3. Justificación
La gamificación y los videojuegos educativos han demostrado ser herramientas altamente
efectivas. Según investigaciones y meta-análisis en metodologías GBL (Game-Based
Learning), el uso de juegos serios es significativamente más efectivo para el aprendizaje y la
retención de conocimiento en comparación con los métodos convencionales de instrucción
(Wouters et al., 2013).
Tabla 2 Beneficios del aprendizaje basado en juegos (GBL) en el contexto del proyecto
Beneficio Descripción
Aprendizaje Contextualizado Contenido basado en ecosistemas y especies reales del
litoral peruano.
Simulación de Problemas Reales El estudiante enfrenta situaciones como contaminación
por plástico, caza furtiva y fenómenos climáticos.
Pensamiento Crítico Cada decisión tiene consecuencias narradas que
desarrollan el análisis causa-efecto.
Motivación Intrínseca La narrativa, el progreso del personaje y el registro
científico generan compromiso sostenido.
Inclusión Tecnológica Bajo costo de hardware requerido y posibilidad de uso en
centros educativos con recursos limitados.
Nota: Resume las ventajas cognitivas y motivacionales de implementar simulaciones
interactivas (GBL) en contraste con la enseñanza pasiva y bidireccional.
4. Objetivos del Proyecto
4.1 Objetivo General
Desarrollar un videojuego educativo utilizando el motor gráfico de Godot Engine y su lenguaje
GDScript, implementando su arquitectura estándar basada en nodos y el sistema de señales
para gestionar de manera eficiente la interactividad, la interfaz de usuario (mediante Control
Nodes) y el flujo de misiones. Esta base tecnológica permitirá a los estudiantes explorar,
comprender y tomar decisiones responsables sobre la biodiversidad y los problemas
ambientales del litoral peruano. A través de estas mecánicas impulsadas por el motor gráfico,
se simularán las consecuencias dinámicas de cada elección, fomentando el pensamiento crítico
y el aprendizaje continuo activo
4.2 Objetivos Específicos
• Diseñar una narrativa interactiva con misiones basadas en casos reales del litoral
peruano, vinculando contenido educativo con mecánicas de juego.
• Implementar un sistema de toma de decisiones con consecuencias dinámicas que
reflejan el impacto ambiental real de cada elección.
• Desarrollar un registro científico dinámico ("Bitácora del Guardián") que consolide el
aprendizaje acumulado por el jugador durante cada sesión.
• Estructurar el proyecto mediante una arquitectura de Escenas y Nodos en Godot
Engine, aplicando principios de composición y POO a través de GDScript para asegurar
un código modular, escalable y de fácil mantenimiento.
• Garantizar una experiencia de usuario fluida e intuitiva, optimizada para entornos
educativos con equipos de recursos limitados.
• Evaluar la comprensión del jugador mediante preguntas contextuales integradas al flujo
narrativo del juego.
5. Concepto del Juego
5.1 Propuesta de Valor
Guardianes del Litoral Peruano es un videojuego educativo de exploración y narrativa donde el
jugador encarna a Valentina Ríos, una investigadora científica del Instituto del Mar del Perú
(IMARPE), enviada a distintas zonas del litoral para documentar el estado de los ecosistemas
costeros.
Cada zona tiene su propia identidad visual, problemática ambiental y elenco de
personajes secundarios (pescadores, biólogos locales, funcionarios). El jugador debe recolectar
evidencia, interactuar con la comunidad y tomar decisiones éticas que afectarán el desenlace
de cada misión.
5.2 Ambientación y Zonas
Tabla 3 Zonas del litoral peruano y sus respectivas especies clave
Zona Especie Clave / Ecosistema
Reserva Nacional de Paracas Tortuga Marina Verde (Chelonia mydas)
Islas Ballestas Lobo Marino de Un Pelo (Otaria flavescens)
Bahía de Sechura Concha de Abanico (Argopecten purpuratus)
Humedales de Villa Flamenco Andino (Phoenicoparrus andinus)
Punta San Juan Pingüino de Humboldt (Spheniscus humboldti)
Nota: Presenta la correlación geográfica entre los diversos ecosistemas de la costa y las
especies endémicas seleccionadas como bioindicadores para el juego.
5.3 Tono y Estética
• Estilo visual: pixel art de 16 bits con paleta de colores costeros (azules, verdes, arena).
• Música ambiental: sonidos del océano, cantos de aves y música andina suave.
• Narrativa: tono serio pero accesible, con toques de humor situacional para mantener el
interés.
• Idioma: español peruano coloquial con términos técnicos explicados en contexto.
6. Soporte Social Histórico
El diseño narrativo de Guardianes del Litoral Peruano se nutre de un sólido respaldo social e
histórico que enmarca cada misión dentro de una realidad cultural y comunitaria auténtica. El
litoral peruano no es solo un ecosistema natural: es el escenario de siglos de coexistencia entre
comunidades humanas y el mar.
6.1 Contexto Histórico de las Comunidades Costeras
Tabla 4 Contexto histórico de las comunidades costeras peruanas
Período Comunidad / Cultura Relación con el Litoral
Antiguo Perú (s.
III–XV)
Cultura Paracas y Nazca Dependencia total del mar: pesca, guano y rutas
comerciales costeras. Desarrollaron técnicas de
pesca con redes de fibra vegetal.
Período Colonial
(s. XVI–XIX)
Pueblos pescadores
mestizos
Incorporación de nuevas especies marinas a la
dieta. Surgimiento de comunidades caletas a lo
largo del litoral.
Siglo XX Comunidades artesanales
modernas
Formación de gremios de pescadores. Primeras
regulaciones estatales de pesca (IMARPE
fundado en 1964).
Actualidad Guardianes comunitarios Participación activa en programas de
conservación marina, con apoyo del Estado y
ONG internacionales.
Nota: Sintetiza la evolución temporal de la dependencia económica y cultural de las diferentes
comunidades humanas frente a los recursos biológicos del mar.
6.2 Movimientos Sociales de Conservación
La defensa del litoral peruano ha sido impulsada históricamente por actores sociales diversos:
• Pescadores artesanales organizados que han resistido la industrialización predatoria de
los recursos marinos.
• Comunidades indígenas costeras que transmiten conocimientos tradicionales sobre
ciclos de pesca y conservación.
• Organizaciones ambientales como la Sociedad Peruana de Derecho Ambiental (SPDA)
y WWF Perú, han impulsado políticas de protección marina.
• Iniciativas juveniles de limpieza de playas y monitoreo ciudadano de biodiversidad
costera.
6.3 Integración en el Juego
Cada misión refleja este soporte social histórico mediante:
• Diálogos con NPC que hacen referencia a tradiciones y conflictos históricos locales.
• Documentos y artefactos coleccionables (fotos antiguas, titulares de periódico, registros
científicos) que contextualizan la problemática actual.
• Decisiones que replican dilemas reales que las comunidades costeras peruanas han
enfrentado históricamente.
• Una línea de tiempo visual en la Bitácora que conecta el pasado histórico con el
presente de cada zona.
7. Personajes — Características
El universo de Guardianes del Litoral Peruano está poblado por personajes con profundidad
psicológica, motivaciones propias y roles funcionales dentro de la narrativa educativa. Se
dividen en personaje principal y personajes secundarios (NPC).
7.1 Personaje Principal
Valentina Ríos — La Guardiana
Tabla 5 Atributos y características del personaje principal (Valentina Ríos)
Atributo Descripción
Edad 28 años
Ocupación Investigadora científica — IMARPE (Instituto del Mar del Perú)
Origen Ica, Perú. Creció en la costa y desarrolló amor por el mar desde
niña.
Personalidad Curiosa, empática, determinada. Cree en la ciencia, pero también
respeta el conocimiento local.
Habilidades Análisis de evidencia, comunicación con comunidades, toma de
decisiones bajo presión.
Motivación Proteger los ecosistemas que conoció en su infancia antes de que
desaparezcan definitivamente.
Arco Narrativo A lo largo del juego, Valentina descubre que la conservación no es
solo científica: también es profundamente humana y política.
Representación Visual Pixel art: mujer morena, cabello recogido, chaqueta de campo verde
con parches de fauna marina, tablet científica.
Nota: Detalla el perfil psicológico, contexto biográfico y atributos lógicos del avatar que permitirá
concretar la narrativa interactiva del jugador.
7.2 Personajes Secundarios (NPC)
Tabla 6 Personajes secundarios (NPC) y su rol interactivo en el juego
Nombre Zona Rol Carácter Función en el Juego
Dr. Alejandro
Ramos
Paracas Biólogo marino —
SERNANP
Metódico,
cauteloso,
optimista a largo
plazo.
Aporta datos científicos
y expone el dilema
entre intervención
rápida y regulación
oficial.
Carmen
Huanca
Paracas Pescadora
artesanal
Pragmática,
desconfiada de
las instituciones,
profundamente
conocedora del
mar.
Representa la voz
comunitaria. Sus
diálogos generan
dilemas éticos sobre
economía y
conservación.
Rodrigo
Palomino
Ballestas Guía turístico local Alegre, orgulloso
de su tierra,
preocupado por
el futuro.
Informa sobre el
impacto económico del
turismo y sus efectos
sobre la fauna.
Sra. Felipa
Quispe
Humedales
de Villa
Vecina activista Combativa,
organizada, líder
comunitaria.
Plantea el conflicto
urbano-ambiental y
motiva a Valentina a
actuar más allá de la
ciencia.
Ing. Marco
Suárez
Sechura Acuicultor local Pragmático,
empresarial, con
conciencia
ambiental
emergente.
Representa los
intereses económicos y
la posibilidad de
desarrollo sostenible.
Dra. Lucía
Torres
Punta San
Juan
Ornitóloga
voluntaria
Apasionada,
introvertida,
dedicada al
monitoreo del
pingüino.
Guía el aprendizaje
sobre bioindicadores y
el rol del pingüino en el
ecosistema.
Nota: Describe los personajes automáticos (NPC) que interactúan lógicamente con el entorno,
representando las diversas posturas éticas y laborales de la comunidad.
7.3 Antagonistas Contextuales
El juego no tiene un villano clásico. En su lugar, los antagonistas son sistemas y actores
sociales que representan fuerzas reales:
Tabla 7 Antagonistas contextuales identificados por zona geográfica
Antagonista Representación Zona Asociada
El Armador Industrial Empresario de flota pesquera que
presiona por ampliar cuotas de captura.
Ballestas / Sechura
El Desarrollador
Inmobiliario
Promotor que busca construir sobre
humedales protegidos.
Villa / Lima
El Turismo Masivo
Irresponsable
Oleadas de turistas sin regulación que
dañan ecosistemas frágiles.
Paracas / Ballestas
La Indiferencia
Institucional
Funcionarios lentos o corruptos que
bloquean acciones de conservación.
Todas las zonas
Nota: Clasifica a los actores y dinámicas económico-sociales que generan directamente las
problemáticas ambientales a ser resueltas computacionalmente.
8. Escenarios
Cada escenario del juego es una representación fiel de una zona del litoral peruano, diseñada
con rigor geográfico y estética pixel art de 16 bits. Los escenarios son espacios vivos que
reaccionan a las decisiones del jugador a lo largo de la partida.
8.1 Estructura Visual de Cada Escenario
Tabla 8 Estructura visual técnica para el desarrollo de los escenarios
Elemento Descripción Técnica
Mapa base Grid 32x24 tiles de 32px cada uno (1280x720 px por zona). Capas:
fondo, terreno, decorado, interactivos, NPC.
Paleta de colores Azul oceánico (#1A6B8A), verde litoral (#2E8B57), arena (#E8D5A3),
cielo costero (#87CEEB).
Ciclo día/noche Cada zona tiene filtro de iluminación que cambia según el avance de la
misión.
Fauna visible Sprites animados de la especie clave aparecen en el escenario; su
número disminuye si el jugador toma decisiones negativas.
Indicadores ambientales Elementos visuales (basura, agua turbia, humo) que aumentan o
disminuyen según el estado de conservación.
Nota: Especifica la configuración espacial de capas algorítmicas y métricas de resolución (Grid
de 32x24) requeridas por el motor para renderizar el entorno fluidamente.
8.2 Descripción Detallada de Cada Escenario
Escenario 1 — Reserva Nacional de Paracas
Tabla 9 Elementos narrativos y visuales del Escenario 1 (Reserva Nacional de Paracas)
Aspecto Detalle
Ambientación Desierto costero y playas de arena fina. Acantilados rojizos con colonia de
tortugas anidando.
Puntos de Interés Playa de anidación de tortugas, campamento científico del SERNANP,
zona de pesca artesanal, acumulación de plásticos flotantes.
Condiciones Iniciales Playa con basura visible, tortuga enredada en red. Clima: sol intenso y
brisa marina.
Transformación Positiva Playa limpia, nidales protegidos, carteles educativos, tortuga libre
nadando en el océano.
BGM Sonido de olas, viento costero, llamadas de aves marinas.
Nota: Define las variables de estado inicial, mecánicas interactivas y componentes
audiovisuales asignados algorítmicamente al mapa local.
Escenario 2 — Islas Ballestas
Tabla 10 Elementos narrativos y visuales del Escenario 2 (Islas Ballestas)
Aspecto Detalle
Ambientación Islas rocosas con cuevas naturales. Colonia masiva de lobos marinos,
aves guaneras y pingüinos.
Puntos de Interés Acantilados con lobería, zona de buceo, embarcadero de guano, muelle
de turismo.
Condiciones Iniciales Lobos marinos visiblemente delgados. Banco de anchovetas escaso.
Botes de pesca en zona restringida.
Transformación Positiva Lobos marinos saludables, banco de anchovetas restaurado, zona de
exclusión respetada.
BGM Ladridos de lobos marinos, graznidos de guanayes, viento marino.
Nota: Define las variables de estado inicial, mecánicas interactivas y componentes
audiovisuales asignados algorítmicamente al mapa local.
Escenario 3 — Bahía de Sechura
Tabla 11 Elementos narrativos y visuales del Escenario 3 (Bahía de Sechura)
Aspecto Detalle
Ambientación Bahía tranquila con camas de cultivo de conchas de abanico. Pueblo
pesquero a la orilla.
Puntos de Interés Área de acuicultura, mercado de mariscos, laboratorio oceánico flotante,
zona de marea roja.
Condiciones Iniciales Proliferación algal visible (marea roja). Cultivos de concha amenazados.
Debate entre pescadores y acuicultores.
Transformación Positiva Aguas limpias, cultivos en expansión sostenible, coexistencia entre pesca
artesanal y acuicultura.
BGM Sonido de botes de remo, vendedores del mercado, brisa del norte
peruano.
Nota: Define las variables de estado inicial, mecánicas interactivas y componentes
audiovisuales asignados algorítmicamente al mapa local.
Escenario 4 — Humedales de Villa (Lima)
Tabla 12 Elementos narrativos y visuales del Escenario 4 (Humedales de Villa)
Aspecto Detalle
Ambientación Humedal urbano rodeado de edificios y autopistas. Contraste dramático
entre naturaleza y ciudad.
Puntos de Interés Laguna central con flamencos, zona de construcción ilegal, centro de
visitantes, punto de monitoreo de agua.
Condiciones Iniciales Maquinaria de construcción en el borde del humedal. Agua con signos de
contaminación. Flamencos inquietos.
Transformación Positiva Construcción detenida, muro perimetral de protección, flamencos
nidificando en la laguna.
BGM Ruido urbano de fondo, canto de aves acuáticas, sonido de viento entre
totorales.
Nota: Define las variables de estado inicial, mecánicas interactivas y componentes
audiovisuales asignados algorítmicamente a la representación urbana del bioma.
Escenario 5 — Punta San Juan (Ica)
Tabla 13 Elementos narrativos y visuales del Escenario 5 (Punta San Juan)
Aspecto Detalle
Ambientación Punta rocosa con colonia mixta de pingüinos, piqueros y lobos marinos.
Zona de exclusión pesquera.
Puntos de Interés Colonia de pingüinos, puesto de monitoreo, embarcación de turismo
ilegal, cueva de anidación.
Condiciones Iniciales Embarcación turística no autorizada perturbando la colonia. Polluelos de
pingüino en riesgo.
Transformación Positiva Zona protegida, sistema de monitoreo remoto activo, colonia de pingüinos
en expansión.
BGM Viento fuerte costero, graznidos de piqueros, chapoteo del océano en las
rocas.
Nota: Define las variables de estado inicial, mecánicas interactivas y componentes
audiovisuales asignados algorítmicamente al mapa local.
9. Sistema de Toma de Decisiones
La toma de decisiones es el núcleo pedagógico y narrativo del juego. No existe una respuesta
trivialmente correcta: cada elección presenta ventajas, costos y consecuencias reales que el
jugador debe ponderar con la información recolectada durante la exploración.
9.1 Principios de Diseño de Decisiones
• Dilema real: cada decisión está basada en situaciones históricas o actuales
documentadas en el litoral peruano.
• Consecuencias ramificadas: las decisiones afectan no solo el resultado inmediato, sino
el estado de la zona en misiones posteriores.
• Sin respuesta obvia: el juego evita decisiones triviales. Cada opción tiene un costo
educativo o ético asociado.
• Retroalimentación narrativa: el resultado se comunica mediante cinemáticas de texto,
cambios visuales en el escenario y voz del NPC.
• Reversibilidad limitada: el jugador puede reintentar con penalización de PK, fomentando
la reflexión antes de actuar.
9.2 Árbol de Decisiones por Misión
Tabla 14 Árbol de decisiones y sus impactos narrativos por misión
Misión Decisión
Central
Opción A Opción B Opción C Impacto
Narrativo
Misión 1
—
Paracas
¿Cómo
proteger a la
tortuga
marina?
Organizar
campaña de
limpieza
comunitaria
(acción
inmediata,
efecto local).
Reportar a
SERNANP
para
intervención
oficial (acción
lenta, efecto
sistémico).
Ignorar y
continuar
investigación
(inacción,
consecuencia
s negativas).
A+B: tortuga
rescatada,
programa de
monitoreo
iniciado. C:
tortuga muere,
ecosistema
deteriorado.
Misión 2
—
Ballestas
¿Cómo
equilibrar
pesca y
conservación?
Proponer veda
temporal
concertada
con
pescadores
(consenso,
efecto medio
plazo).
Solicitar
ampliación de
zona de
exclusión
pesquera
(legal,
conflictivo a
corto plazo).
No intervenir,
esperar más
datos (riesgo
de colapso del
banco de
anchovetas).
A: relación
positiva con
comunidad. B:
conflicto con
pescadores pero
protección
efectiva. C:
deterioro
progresivo.
Misión 3
— Villa
¿Cómo
defender el
humedal
urbano?
Aliarse con
activistas
locales para
bloqueo legal
(acción
ciudadana).
Presentar
informe
técnico ante
Municipalidad
de Lima
(acción
institucional).
Documentar y
publicar en
medios
digitales
(acción
mediática,
resultado
incierto).
A+B: construcción
detenida,
humedal
protegido. C:
proceso lento,
flamencos
parcialmente
afectados.
Misión 4
—
Sechura
¿Cómo
manejar la
marea roja?
Implementar
sistema de
alerta
temprana con
sensores
(tecnología,
costo alto).
Coordinar con
acuicultores
para cierre
temporal de
camas
(económico,
consensuado).
Solicitar
estudio de
impacto
ambiental al
MINAM
(burocrático,
largo plazo).
A+B: producción
protegida, modelo
replicable. C:
daño a cultivos
durante espera
institucional.
Misión 5
— Punta
San Juan
¿Cómo
proteger la
colonia de
pingüinos?
Instalar boyas
de exclusión y
cámaras de
monitoreo
(solución
tecnológica).
Trabajar con
operadores
turísticos para
protocolo de
visita
responsable
(educación).
Denunciar a
autoridades y
esperar
sanción (legal,
proceso
lento).
A+B: colonia
protegida, turismo
sostenible
habilitado. C:
proceso largo,
daño continuo
durante espera.
Nota: Esquematiza las bifurcaciones narrativas de la simulación, demostrando lógicamente
cómo cada rama seleccionada detona consecuencias ecosistémicas de código.
9.3 Mecánica de Consecuencias Dinámicas
Las consecuencias de las decisiones no son estáticas. Se manifiestan en tres niveles:
Tabla 15 Niveles de manifestación de las consecuencias dinámicas
Nivel Tipo de Consecuencia Manifestación en el Juego
Inmediato Cinemática narrativa
(texto + imagen)
Animación que muestra el efecto directo de la decisión
sobre la especie o el ecosistema.
Progresivo Cambio visual del
escenario
El mapa de la zona refleja mejora o deterioro ambiental
en misiones subsiguientes.
Acumulativo Puntaje de Impacto (PI) y
Bitácora
El historial de decisiones genera un perfil de guardián:
conservacionista, pragmático o negligente.
9.4 Sistema de Retroalimentación Educativa
Cuando el jugador elige una opción subóptima o incorrecta, el juego no sanciona de forma
punitiva. En cambio:
• Presenta una pantalla de Lección Aprendida con datos científicos reales sobre la
consecuencia de esa elección.
• Incluye una cita de un experto real (biólogos del IMARPE, activistas del SPDA) que
contextualiza la decisión.
• Permite reintentar la decisión con una penalización del 25% de los Puntos de
Conocimiento (PK).
• Registra la decisión original en la Bitácora como aprendizaje documentado, no como
error oculto.
9.5 Decisiones con Impacto Transversal
Ciertas decisiones tomadas en una misión afectan el estado inicial de misiones posteriores,
creando una red de consecuencias narrativas:
Tabla 16 Impacto transversal de las decisiones en misiones posteriores
Decisión en Misión Efecto en Misión Posterior
Misión 1: Alianza con Dr. Ramos
(SERNANP)
Misión 3: SERNANP apoya el caso de los Humedales de Villa
con respaldo técnico adicional.
Misión 2: Veda consensuada con
pescadores
Misión 4: Pescadores de Sechura colaboran voluntariamente
en cierre temporal de camas.
Misión 3: Publicación mediática
exitosa
Misión 5: Mayor cobertura mediática del caso Punta San Juan,
más presión sobre autoridades.
Decisiones negativas acumuladas
(2+)
El mapa principal muestra indicadores de deterioro ambiental y
NPC expresan desconfianza hacia Valentina.
Nota: Establece la matriz de dependencias lógicas donde los parámetros modificados en
misiones previas alteran directamente el estado inicial de las variables futuras.
10. Mecánicas del Juego
10.1 Flujo de Cada Misión
Cada misión sigue una estructura pedagógica de 7 fases inspirada en el modelo de aprendizaje
experiencial de Kolb:
Tabla 17 Fases pedagógicas en el flujo interactivo de cada misión
Fase Descripción
1. Briefing Video-texto introductorio que contextualiza el problema ambiental de la
zona.
2. Exploración El jugador recorre el mapa de la zona, recolectando pistas e interactuando
con el entorno.
3. Interacción con NPC Diálogos ramificados con personajes locales que aportan datos, opiniones
y dilemas.
4. Análisis de Evidencia El jugador revisa la información recolectada en su inventario científico.
5. Pregunta Contextual Pregunta de opción múltiple o decisión ética basada en la evidencia.
6. Consecuencias Animación y texto que narran el impacto de la decisión tomada sobre el
ecosistema.
7. Registro La especie, amenaza y solución elegida se añaden automáticamente a la
Bitácora.
Nota: Modela la secuencia de ejecución de eventos requerida algorítmicamente para completar
el loop de aprendizaje experiencial dentro de una zona.
10.2 Sistema de Puntuación
• Puntos de Conocimiento (PK): otorgados por respuestas correctas y exploración
completa.
• Puntos de Impacto (PI): reflejan las consecuencias de las decisiones tomadas sobre el
ecosistema.
• Insignias de Guardián: recompensas especiales por completar misiones con el máximo
de PK y PI positivo.
10.3 Sistema de Decisiones Ramificadas
• Las decisiones del jugador generan tres tipos de desenlace:
• Desenlace Positivo: la especie es protegida, la comunidad mejora, se desbloquea nueva
zona.
• Desenlace Neutral: se mitiga el daño pero no se resuelve el problema completamente.
• Desenlace Negativo: el ecosistema se deteriora, el jugador recibe retroalimentación
educativa y puede reintentar.
11. Sistema de Progreso — La Bitácora del Guardián
La Bitácora del Guardián es el elemento central de progreso del juego. Es un registro científico
persistente que el jugador construye a lo largo de todas las misiones. Funciona como portafolio
de aprendizaje y sirve como herramienta de evaluación docente.
11.1 Campos del Registro
Tabla 18 Campos de registro y tipos de datos de la Bitácora del Guardián
Campo Descripción Tipo de Dato
ID Misión Identificador único de la misión completada String
Zona Nombre de la zona explorada String
Especie Nombre científico y común de la especie estudiada String
Amenaza Tipo de amenaza ambiental identificada String
Decisión Elección tomada por el jugador String
Resultado Tipo de desenlace: Positivo / Neutral / Negativo String
PK Obtenidos Puntos de conocimiento acumulados en la misión Integer
Fecha Timestamp de la sesión de juego DateTime
Nota: Detalla el esquema relacional de la base del sistema y los tipos de variables nativas
requeridas para procesar el aprendizaje computacional del usuario en JSON.
11.2 Exportación
Al finalizar todas las misiones, la Bitácora puede exportarse en formato JSON o CSV,
permitiendo al docente analizar el desempeño del estudiante de manera cuantitativa y
cualitativa.
12. Requerimientos Funcionales
Tabla 19 Requerimientos funcionales del sistema (RF)
ID Descripción del Requerimiento Prioridad
RF-01 El sistema debe permitir la navegación entre 5 zonas del litoral mediante un
mapa interactivo.
Alta
RF-02 El sistema debe gestionar un sistema de misiones con estado (pendiente,
en progreso, completada).
Alta
RF-03 El sistema debe presentar diálogos ramificados con al menos 3 opciones de
respuesta por NPC.
Alta
RF-04 El sistema debe evaluar al jugador mediante preguntas contextuales de
opción múltiple.
Alta
RF-05 El sistema debe registrar automáticamente cada especie estudiada en la
Bitácora del Guardián.
Alta
RF-06 El sistema debe calcular y mostrar el puntaje acumulado (PK y PI) en
tiempo real.
Media
RF-07 El sistema debe mostrar animaciones de consecuencia al tomar decisiones. Media
RF-08 El sistema debe permitir exportar la Bitácora al formato de JSON nativo de
Godot al finalizar el juego.
Media
RF-09 El sistema debe incluir un tutorial interactivo para jugadores nuevos. Baja
RF-10 El sistema debe gestionar la persistencia del progreso del jugador utilizando
la clase FileAccess, permitiendo guardar y cargar el estado de las misiones
y los puntos acumulados (PK y PI) en el almacenamiento local del
dispositivo
Baja
Nota: Enumera exhaustivamente los módulos obligatorios de procesamiento lógico que el
bloque central debe soportar para garantizar el flujo y propósito educativo.
13. Requerimientos No Funcionales
Tabla 20 Requerimientos no funcionales del sistema (RNF)
ID Descripción del Requerimiento Categoría
RNF-01 La interfaz debe ser intuitiva, con aprendizaje de uso en menos de 5
minutos.
Usabilidad
RNF-02 El juego debe ejecutarse en equipos con mínimo 2 GB de RAM y
procesador dual-core.
Rendimiento
RNF-03 El tiempo de carga entre zonas no debe superar 3 segundos en hardware
estándar.
Rendimiento
RNF-04 El código debe seguir arquitectura de escenas, nodo y composición. Mantenibilid
ad
RNF-05 El código debe estar documentado con docstrings y comentarios
explicativos.
Mantenibilid
ad
RNF-06 Los datos del juego deben almacenarse en JSON con estructura validada
por esquema.
Confiabilida
d
RNF-07 El sistema debe ser compatible con Windows 10+, macOS 12+ y Ubuntu
22.04+, como también el sistema será compatible con web (HTML5)
Portabilidad
RNF-08 La resolución mínima soportada debe ser 1280x720 píxeles. Compatibilid
ad
Nota: Establece los atributos de calidad del software y límites de carga, restringiendo
parámetros operativos de rendimiento, compatibilidad de SO y tolerancia.
14. Casos de Uso
14.1 Actores del Sistema
• Jugador/Estudiante: interactúa directamente con el videojuego.
• Sistema: componente interno que procesa lógica, guarda datos y genera respuestas.
• Docente (externo): revisa la Bitácora exportada para evaluación.
14.2 Descripción de Casos de Uso
Tabla 21 Especificación del caso de uso CU-01: Iniciar nueva partida
Atributo CU-01: Iniciar Nueva Partida
Actor Principal Jugador
Precondición El sistema está instalado y en estado inicial.
Flujo Principal El jugador selecciona 'Nueva Partida', ingresa su nombre y comienza en
el mapa principal.
Flujo Alternativo El jugador puede cargar una partida guardada previamente.
Postcondición Se inicializa la Bitácora vacía y se posiciona al jugador en el mapa.
Nota: Modela la transacción primaria que inicializa las variables globales en memoria RAM y
prepara los motores gráficos para la instancia activa.
Tabla 22 Especificación del caso de uso CU-02: Explorar zona
Atributo CU-02: Explorar Zona
Actor Principal Jugador
Precondición El jugador está en el mapa principal con al menos una zona
desbloqueada.
Flujo Principal El jugador selecciona una zona, visualiza el briefing y comienza la
exploración libre del mapa local.
Flujo Alternativo Si la zona está bloqueada, el sistema muestra los requisitos para
desbloquearla.
Postcondición El jugador ha recorrido la zona y recolectado al menos una pista.
Nota: Modela los subprocesos lógicos subyacentes a la interacción asíncrona del avatar y la
validación de bloqueos espaciales del área interactiva.
Tabla 23 Especificación del caso de uso CU-03: Resolver misión
Atributo CU-03: Resolver Misión
Actor Principal Jugador / Sistema
Precondición El jugador ha completado la exploración de la zona y tiene evidencia
suficiente.
Flujo Principal El sistema presenta la pregunta contextual. El jugador elige una
respuesta. El sistema evalúa, muestra consecuencias y actualiza la
Bitácora.
Flujo Alternativo Si el jugador elige incorrectamente, puede revisar la evidencia y reintentar
con penalización de PK.
Postcondición La misión queda registrada como completada con su resultado.
Nota: Modela matemáticamente las validaciones para captura de inputs locales, su
contrastación con la base de reglas lógicas y la sobreescritura de persistencia.
15. Arquitectura del Sistema
15.1 Stack Tecnológico
Tabla 24 Stack tecnológico definido para la arquitectura del sistema
Componente Tecnología / Herramienta
Lenguaje Principal GDScript 2.0 (basado en Python pero optimizado para nodos)
Motor Gráfico Godot 4.6.2
Gestión de Datos JSON (vía clases nativas JSON y FileAccess)
Arquitectura de Código Orientada a Escenas, Nodos y Composición
Control de Versiones Git + GitHub
Documentación Comentarios de documentación nativos de GDScript (GDScript
Documentation Comments) + README.md
Sistema de UI Control Nodes con sistema de anclajes para diseño responsivo
Nota: Categoriza el motor gráfico (Godot), el lenguaje nativo (GDScript) y la arquitectura
orientada a Escenas y Nodos designada para mantener la escalabilidad estructural del
videojuego.
15.2 Módulos del Sistema
En Godot, el sistema se organiza mediante escenas modulares que combinan nodos y script de
GDScript:
• Main.tscn / Main.gd: Escena raíz y punto de entrada que gestiona la carga inicial y el
cambio entre las escenas de juego.
• GameManager.gd: Singleton (Autoload) que gestiona el estado global, variables
persistentes y la transición de estados del juego.
• MapScene.tscn / MapScene.gd: Escena del mapa interactivo que utiliza nodos de tipo
TextureButton para la navegación entre zonas.
• MissionEngine.gd: Script encargado de procesar la lógica de misiones, validación de
respuestas y evaluación del impacto ambiental.
• NPCSystem.tscn: Sistema basado en nodos de CanvasLayer para la gestión de
diálogos ramificados y árboles de conversación.
• DataManager.gd: Maneja la persistencia de datos mediante las clases nativas
FileAccess y JSON (lectura/escritura del progreso y Bitácora)
• UIComponents.tscn: Colección de nodos de tipo Control (botones, barras de progreso y
cuadros de diálogo) reutilizables en todo el proyecto.
• AudioManager.tscn: Nodo centralizado con múltiples AudioStreamPlayer para la gestión
de música ambiental y efectos de sonido.
15.3 Flujo General del Sistema
Inicio → Menú Principal → Selección de Zona → Briefing → Exploración → Interacción NPC →
Análisis de Evidencia → Pregunta / Decisión → Cálculo de Consecuencias → Animación de
Resultado → Actualización Bitácora → Retorno a Mapa → [Siguiente Misión o Fin del Juego]
16. Plan de Desarrollo
16.1 Metodología
El proyecto se desarrollará bajo una metodología ágil adaptada (Scrum simplificado), con
sprints de dos semanas y reuniones de revisión al final de cada fase. Se utilizará un tablero
Kanban en GitHub Projects para el seguimiento de tareas.
16.2 Fases y Cronograma
Tabla 25 Fases y cronograma del plan de desarrollo ágil
Fase Actividades Principales Duración
Fase 1: Análisis Investigación bibliográfica, definición de
requerimientos, validación con docente.
1 semana
Fase 2: Diseño Diseño orientado a escenas, nodos y composición,
wireframes de UI, diseño de misiones y diálogos.
1 semana
Fase 3: Desarrollo Programación de módulos (mapa, misiones, NPC,
Bitácora, audio), integración.
3 semanas
Fase 4: Pruebas Testing unitario mediante el framework GUT (Godot
Unit Test) y uso del depurador nativo del motor,
pruebas de usabilidad con usuarios, corrección de
bugs.
1 semana
Fase 5: Presentación Empaquetado del ejecutable, documentación final,
demo en vivo.
1 semana
Nota: Proyecta algorítmica y económicamente los tiempos de desarrollo divididos en
micro-iteraciones (sprints) priorizadas para el despliegue funcional.
16.3 Distribución de Roles
Tabla 26 Distribución de roles y responsabilidades del equipo de desarrollo
Rol Responsabilidades
Líder de Proyecto Gestión del cronograma, coordinación de equipo, comunicación con
docente.
Desarrollador Backend Módulos de lógica: mission_engine, data_manager, game_manager.
Desarrollador Frontend Módulos de visualización: map_scene, ui_components,
audio_manager.
Diseñador de Contenido Guiones de NPC, textos educativos, diseño de preguntas y
consecuencias.
QA / Tester Casos de prueba, reporte de bugs, pruebas de usabilidad.
Nota: Tipifica el reparto estratégico de responsabilidades en diseño de arquitectura, QA
(aseguramiento de calidad) y levantamiento de requerimientos front/back end.
17. Gestión de Riesgos
Tabla 27 Gestión de riesgos, impacto técnico y estrategias de mitigación (Godot Engine)
Riesgo Impacto Mitigación
Complejidad técnica de Godot Alto Prototipar mecánicas clave en la primera semana.
Complejidad en la jerarquía de
Escenas
Medio Definir una estructura modular estricta y utilizar la
técnica de "Instanciación de Escenas" para evitar el
acoplamiento de código.
Conflictos de importación de
Assets (Archivos .import)
Medio Configurar un archivo .gitignore robusto específico
para Godot y realizar pruebas de integridad de
texturas en el repositorio cada sprint.
Desequilibrio de carga de
trabajo en el motor
Medio Revisión semanal del tablero Kanban en GitHub
Projects para redistribuir tareas de diseño de
escenas y scripting.
Errores en la serialización
JSON / FileAccess
Bajo Implementar validación de diccionarios antes de la
escritura y usar bloques if FileAccess.file_exists()
para evitar cierres inesperados al cargar la Bitácora
Incompatibilidad de plugins o
versiones de Godot
Bajo Utilizar una versión estable específica (ej. Godot
4.3) para todo el equipo y documentar
dependencias en el archivo project.godot
Nota: Mapea probabilísticamente los fallos sistémicos u operativos inherentes del desarrollo,
adjuntando la respectiva contingencia técnica para encapsular su riesgo.
18. Conclusiones
Guardianes del Litoral Peruano es un proyecto que va más allá del desarrollo de software:
constituye una propuesta pedagógica concreta que emplea la tecnología como medio para
generar conciencia ambiental y fomentar competencias del siglo XXI en los estudiantes.
El diseño modular implementado en GDScript dentro del motor Godot Engine garantiza
la viabilidad técnica del proyecto dentro del alcance del curso, aprovechando una arquitectura
basada en nodos y escenas que facilita la reutilización de componentes y la escalabilidad del
sistema. Asimismo, el uso de estructuras de datos en JSON y la implementación de un sistema
de Bitácora evidencian la comprensión de principios fundamentales de ingeniería de software,
tales como la persistencia de datos, la separación de responsabilidades y el diseño centrado en
el usuario. Este documento establece una base sólida para el desarrollo del proyecto, con
requerimientos claramente definidos, casos de uso documentados, un modelo de datos
estructurado y un plan de trabajo realista. El equipo se encuentra comprometido con la entrega
de un producto funcional, con valor educativo significativo y una base técnica robusta.
