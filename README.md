#  MLChallenge
## App examen para candidatura como desarrollador iOS de ML


## Cosas a mejorar
- Los mensajes al usuario en la TableView no tienen un muy buen diseño.
- Cargado de más resultados al llegar al final de la table view (paginado).
- Mostrar más detalles en la pantalla de detalles.

### Cada pantalla deberíamos poder rotarla y debería mantenerse el estado de la vista.
Sin comentarios

### Test unitarios de la lógica del proyecto.
El proyecto no tiene mucha lógica de negocios. O es codigo de UI, o es codigo de servicios.
Como mucho se pueden hacer tests unitarios para corroborar el correcto parseo de distintos payloads falsos. Por eso a la clase ProductSearchItemService se le puede inyectar un URLSession.

### Fundamentos de elección de dependencias de terceros en caso de usarlas.
- Solo [SDWebImage](https://github.com/SDWebImage/SDWebImage) para bajar las imágenes asincronicamente y guardarlas en caché. No usar un caché impactaría en la experiencia de usuario y no usar una dependencia tan usada como esta no justificaría la inversión dado el tiempo acotado.


### Manejo de casos de error desde el punto de vista del developer. Cómo se gestionan los casos de error inesperados, la consistencia a lo largo de toda la app, uso de logs, etc.
Para errores inesperados una vez distribuida la app usaria el Crashes Organizer o un servicio de teceros como Sentry o Friebase Crashlytics.


### Manejo de casos de error desde el punto de vista del usuario. Priorizar una experiencia fluida dando feedback al usuario adecuadamente.
El único error visible para el usuario seria el de falta de conexión a internet.
