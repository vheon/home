if !exists(':Tabularize')
  finish " Tabular.vim wasn't loaded
endif


AddTabularPattern!  define  /^#define\s\%(\S*\)\zs
