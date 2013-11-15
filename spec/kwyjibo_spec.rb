require 'spec_helper'

describe Kwyjibo do
	before :each do
		@a = Kwyjibo::Matriz.new(2,2)
	end

	describe "\n # Matrix data \n" do
		it "### Una matriz tiene su numero de filas almacenadas" do
			@a.rows.should eq(2)
		end

		it "### Una matriz tiene su numero de columnas almacenadas" do
			@a.cols.should eq(2)
		end
	end

	describe "\n # Almacenamiento de datos \n" do
		it "### Se puede acceder a un elemento"
		it "### Se puede acceder y consultar un elemento"
	end

	describe "\n # Tipos de matrices \n" do
		it "### Existe un metodo para saber si es una matriz cuadrada"
		it "### Existe un metodo para saber si es una matriz densa"
		it "### Existe un metodo para saber si es una matriz dispersa"
	end

	describe "\n # Operaciones entre matrices densas" do
		describe "\n  ## Suma de matrices densas \n" do
			it "### Se pueden sumar matrices del mismo tamano"
			it "### No se pueden sumar matrices de distinto tamano"
			it "### El resultado de sumar dos matrices debe ser una matriz"
			it "### La suma de dos matrices debe dar una matriz del mismo tamano"
		end

		describe "\n  ## Resta de matrices densas \n" do
			it "### Se pueden restar matrices del mismo tamano"
			it "### No se pueden restar matrices de distinto tamano"
			it "### El resultado de restar dos matrices debe ser una matriz"
			it "### La resta de dos matrices debe dar una matriz del mismo tamano"
		end

		describe "\n  ## Multiplicacion de matrices densas \n" do
			it "### Se pueden multiplicar dos matrices si el numero de columnas de la primera es igual al numero de de la segunda matriz"
			it "### No se pueden multiplicar dos matrices si el numero de columnas de la primera es distinto al numero de de la segunda matriz"
			it "### El resultado de multiplicar dos matrices debe ser una matriz con numero de filas igual a las filas de la primera matriz y numero de columnas igual al numero de columnas de la segunda matriz"
		end

		describe "\n  ## Producto de matrices densas \n" do
			it "### Se pueden multiplicar dos matrices si el numero de columnas de la primera es igual al numero de de la segunda matriz"
			it "### No se pueden multiplicar dos matrices si el numero de columnas de la primera es distinto al numero de de la segunda matriz"
			it "### El resultado de multiplicar dos matrices debe ser una matriz con numero de filas igual a las filas de la primera matriz y numero de columnas igual al numero de columnas de la segunda matriz"
		end
	end

	describe "\n # Operaciones entre matrices densas y escalares \n" do
		it "Se puede multiplicar una matriz por un escalar"
		it "Se puede dividir una matriz por un escalar"
	end
end