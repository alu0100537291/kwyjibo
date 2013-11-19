require 'spec_helper'

describe Kwyjibo do
	before :each do
		@a = Kwyjibo::DenseMatrix.new(2,2)
		@a[0][0] = 1
		@a[0][1] = 2
		@a[1][0] = 3
		@a[1][1] = 4

		@b = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => 1, 1 => 2})
	end

	describe "\n # Matrix data \n" do
		it "### Una matriz densa tiene su numero de filas almacenadas" do
			@a.rows.should eq(2)
		end

		it "### Una matriz densa tiene su numero de columnas almacenadas" do
			@a.cols.should eq(2)
		end

		it "### Una matriz dispersa tiene su numero de filas almacenadas" do
			@b.rows.should eq(2)
		end

		it "### Una matriz dispersa tiene su numero de columnas almacenadas" do
			@b.cols.should eq(2)
		end
	end

	describe "\n # Operaciones con matrices densas" do
		describe "\n  ## Suma de matrices densas \n" do
			it "### Se pueden sumar matrices del mismo tamano" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = 1
				c[0][1] = 2
				c[1][0] = 3
				c[1][1] = 4

				d = @a + c

				d[0][0].should eq(2)
				d[0][1].should eq(4)
				d[1][0].should eq(6)
				d[1][1].should eq(8)
			end

			it "### No se pueden sumar matrices de distinto tamano" do
				c = Kwyjibo::DenseMatrix.new(2,1)

				c[0][0] = 1
				c[1][0] = 3

				expect {@a + c}.to raise_error(ArgumentError)
			end

			it "### El resultado de sumar dos matrices densas debe ser una matriz densa" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = 1
				c[0][1] = 2
				c[1][0] = 3
				c[1][1] = 4

				d = @a + c

				d.should be_an_instance_of Kwyjibo::DenseMatrix
			end

			it "### La suma de dos matrices densas debe dar una matriz densa del mismo tamano" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = 1
				c[0][1] = 2
				c[1][0] = 3
				c[1][1] = 4

				d = @a + c

				d.rows.should eq(2)
				d.cols.should eq(2)
			end
		end

		describe "\n  ## Resta de matrices densas \n" do
			it "### Se pueden restar matrices del mismo tamano" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = Kwyjibo::Fraccion.new(1,1)
				c[0][1] = Kwyjibo::Fraccion.new(2,1)
				c[1][0] = Kwyjibo::Fraccion.new(3,1)
				c[1][1] = Kwyjibo::Fraccion.new(4,1)

				d = @a - c

				d[0][0].should eq(Kwyjibo::Fraccion.new(0,1))
				d[0][1].should eq(Kwyjibo::Fraccion.new(0,1))
				d[1][0].should eq(Kwyjibo::Fraccion.new(0,1))
				d[1][1].should eq(Kwyjibo::Fraccion.new(0,1))
			end

			it "### No se pueden restar matrices de distinto tamano" do
				c = Kwyjibo::DenseMatrix.new(2,1)

				c[0][0] = Kwyjibo::Fraccion.new(1,1)
				c[1][0] = Kwyjibo::Fraccion.new(3,1)

				expect {@a - c}.to raise_error(ArgumentError)
			end

			it "### El resultado de restar dos matrices densas debe ser una matriz densa" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = 1
				c[0][1] = 2
				c[1][0] = 3
				c[1][1] = 4

				d = @a - c

				d.should be_an_instance_of Kwyjibo::DenseMatrix
			end

			it "### La resta de dos matrices debe dar una matriz del mismo tamano" do
				c = Kwyjibo::DenseMatrix.new(2,2)

				c[0][0] = 1
				c[0][1] = 2
				c[1][0] = 3
				c[1][1] = 4

				d = @a - c

				d.rows.should eq(2)
				d.cols.should eq(2)
			end
		end

		describe "\n  ## Multiplicacion de matrices densas \n" do
			it "### Se pueden multiplicar dos matrices si el numero de columnas de la primera es igual al numero de de la segunda matriz" do
				c = Kwyjibo::DenseMatrix.new(2,5)

				c[0][0] = Kwyjibo::Fraccion.new(1,1)
				c[0][1] = Kwyjibo::Fraccion.new(2,1)
				c[0][2] = Kwyjibo::Fraccion.new(3,1)
				c[0][3] = Kwyjibo::Fraccion.new(4,1)
				c[0][4] = Kwyjibo::Fraccion.new(5,1)
				c[1][0] = Kwyjibo::Fraccion.new(6,1)
				c[1][1] = Kwyjibo::Fraccion.new(7,1)
				c[1][2] = Kwyjibo::Fraccion.new(8,1)
				c[1][3] = Kwyjibo::Fraccion.new(9,1)
				c[1][4] = Kwyjibo::Fraccion.new(10,1)

				d = @a * c

				d[0][0].should eq(Kwyjibo::Fraccion.new(13,1))
				d[0][1].should eq(Kwyjibo::Fraccion.new(16,1))
				d[0][2].should eq(Kwyjibo::Fraccion.new(19,1))
				d[0][3].should eq(Kwyjibo::Fraccion.new(22,1))
				d[0][4].should eq(Kwyjibo::Fraccion.new(25,1))
				d[1][0].should eq(Kwyjibo::Fraccion.new(27,1))
				d[1][1].should eq(Kwyjibo::Fraccion.new(34,1))
				d[1][2].should eq(Kwyjibo::Fraccion.new(41,1))
				d[1][3].should eq(Kwyjibo::Fraccion.new(48,1))
				d[1][4].should eq(Kwyjibo::Fraccion.new(55,1))
			end

			it "### No se pueden multiplicar dos matrices si el numero de columnas de la primera es distinto al numero de de la segunda matriz" do
				c = Kwyjibo::DenseMatrix.new(1,2)

				c[0][0] = 1
				c[0][1] = Kwyjibo::Fraccion.new(2,1)

				expect {@a * c}.to raise_error(ArgumentError)
			end

			it "### El resultado de multiplicar dos matrices debe ser una matriz con numero de filas igual a las filas de la primera matriz y numero de columnas igual al numero de columnas de la segunda matriz" do
				c = Kwyjibo::DenseMatrix.new(2,5)

				c[0][0] = Kwyjibo::Fraccion.new(1,1)
				c[0][1] = Kwyjibo::Fraccion.new(2,1)
				c[0][2] = Kwyjibo::Fraccion.new(3,1)
				c[0][3] = Kwyjibo::Fraccion.new(4,1)
				c[0][4] = Kwyjibo::Fraccion.new(5,1)
				c[1][0] = Kwyjibo::Fraccion.new(6,1)
				c[1][1] = Kwyjibo::Fraccion.new(7,1)
				c[1][2] = Kwyjibo::Fraccion.new(8,1)
				c[1][3] = Kwyjibo::Fraccion.new(9,1)
				c[1][4] = Kwyjibo::Fraccion.new(10,1)

				d = @a * c

				d.rows.should eq(2)
				d.cols.should eq(5)
			end
		end

		describe "\n ##Operaciones entre matrices densas y escalares \n" do
			it "### Se puede multiplicar una matriz densa por un escalar" do
				@a.x(2)

				@a[0][0].should eq(2)
				@a[0][1].should eq(4)
				@a[1][0].should eq(6)
				@a[1][1].should eq(8)
			end
		end

		describe "\n ## Opuesta de una matriz densa \n" do
			it "### Se puede calcular la opuesta de una matriz densa" do
				c = @a.tras

				c[0][0].should eq(1)
				c[0][1].should eq(3)
				c[1][0].should eq(2)
				c[1][1].should eq(4)
			end

			it "### En el calculo de la matriz opuesta de una matriz se intercambian sus filas y columnas" do
				c = Kwyjibo::DenseMatrix.new(2,5)

				c[0][0] = Kwyjibo::Fraccion.new(1,1)
				c[0][1] = Kwyjibo::Fraccion.new(2,1)
				c[0][2] = Kwyjibo::Fraccion.new(3,1)
				c[0][3] = Kwyjibo::Fraccion.new(4,1)
				c[0][4] = Kwyjibo::Fraccion.new(5,1)
				c[1][0] = Kwyjibo::Fraccion.new(6,1)
				c[1][1] = Kwyjibo::Fraccion.new(7,1)
				c[1][2] = Kwyjibo::Fraccion.new(8,1)
				c[1][3] = Kwyjibo::Fraccion.new(9,1)
				c[1][4] = Kwyjibo::Fraccion.new(10,1)

				d = c.tras

				d.rows.should eq(5)
				d.cols.should eq(2)
			end
		end
	end

	describe "\n # Calculo de valores maximos y minimos en una matriz" do
		it "### Se puede calcular el valor maximo de los elementos de una matriz" do
			@a.max.should eq(4)
		end

		it "### Se puede calcular el valor minimo de los elementos de una matriz" do
			@a.min.should eq(1)
		end
	end

	describe "\n # Operaciones con matrices dispersas \n" do
		it "### Sumar dos matrices dispersas" do
			q = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})
			w = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})

			c = q + w

			c[0][0].should eq(2)
			c[0][1].should eq(4)
			c[1][0].should eq(6)
			c[1][1].should eq(8)
		end

		it "### Sumar una matriz densa y otra dispersa" do
			q = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})

			c = @a + q

			c[0][0].should eq(2)
			c[0][1].should eq(4)
			c[1][0].should eq(6)
			c[1][1].should eq(8)
		end

		it "### Sumar una matriz dispersa y otra densa" do
			q = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})

			c = q + @a

			c[0][0].should eq(2)
			c[0][1].should eq(4)
			c[1][0].should eq(6)
			c[1][1].should eq(8)
		end

		it "### Multiplicacion de una matriz dispersa por una densa" do
			q = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => Kwyjibo::Fraccion.new(5,1), 1 => 6})

			c = @a * q

			c[0][0].should eq(5)
			c[0][1].should eq(6)
			c[1][0].should eq(15)
			c[1][1].should eq(Kwyjibo::Fraccion.new(18,1))
		end

		it "### El resultado de multiplicar dos matrices debe ser una matriz con numero de filas igual a las filas de la primera matriz y numero de columnas igual al numero de columnas de la segunda matriz" do
			q = Kwyjibo::SparseMatrix.new(2,2,0 => { 0 => Kwyjibo::Fraccion.new(5,1), 1 => 6})

			c = @a * q

			c.rows.should eq(2)
			c.cols.should eq(2)			
		end
	end
end