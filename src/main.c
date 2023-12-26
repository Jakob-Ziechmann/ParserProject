#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "parse.h"
#include "token.h"
#include "tree.h"
#include "map.h"
#include "eval.h"
#include "lexer.h"


int main(void){

  Ast* tree = parse("(a => b)");

  Map map;

  initializeMap(&map, 2);
  insertIntoMap(&map, "a", 0);
  insertIntoMap(&map, "b", 1);

  ast_print(tree);
  printf(" evaluates to %d\n", evaluateTree(tree, &map));

  return EXIT_SUCCESS;
}
