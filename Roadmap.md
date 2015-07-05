# Roadmap for development of the engine.

# Version 0.2 #

  * Refactor front-end to use Prana framework for injecting dependancies.
  * Rewrite build process to remove 3rd party library sources - just include swc for compile-time linking and swf for runtime loading.
  * Refactor server build to run as an application layer on top of jedai.

## Unversioned Features ##

  * Implement Heirachical Grids for collision culling.
  * Collision response system.
  * Add database support (Hibernate).
  * Abstract engine support - so no reliance on Papervision.
  * AI Steering behaviours and steering pipeline implementation
  * Server-side AI library - State Machine, Scripting etc.

