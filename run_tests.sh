#!/bin/bash
echo "Executando testes da API Restful Booker..."

# Testes básicos (smoke)
echo
echo "=== EXECUTANDO TESTES SMOKE ==="
robot --include smoke --outputdir reports tests/

# Todos os testes
echo
echo "=== EXECUTANDO TODOS OS TESTES ==="
robot --outputdir reports tests/

# Suite completa
echo
echo "=== EXECUTANDO SUITE COMPLETA ==="
robot --outputdir reports tests/suite_completa.robot

echo
echo "Testes concluídos! Verifique os relatórios em reports/"