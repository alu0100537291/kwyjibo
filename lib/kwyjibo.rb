require "kwyjibo/version"

# Modulo donde se crean las clases de la gema para matrices.
#
# Trabajando con Matrices Dispersas y Densas.
# Autores:
# -Jose Alberto Perez Melian
# -Jessica A. Ramos Villarreal
#
module Kwyjibo
    # Clase principal de la gema, de la que heredaran subclases.
    class Matrix
        # Variables para guardar el numero de filas y columnas.
        attr_reader :rows, :cols
        # Metodo constructor de la matriz.
        def initialize(rows,cols)
            # Variables que guardaran el numero de filas y clomunas de la matriz.
            @rows, @cols = rows, cols
        end
        # Metodo que realiza la suma entre matrices cuadradas.
        def +(other)
            # Error en caso de que las matrices sean de diferente tamaño.
            raise ArgumentError, "Matrix size must be equal" unless @rows == other.rows && @cols == other.cols
            # Matriz densa donde se guardara el resultado de la suma.
            c = DenseMatrix.new(@rows, @cols)
            # Recorrido de las matrices para operar.
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] == nil && other[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && other[i][j] != nil
                        c[i][j] = other[i][j]
                    elsif self[i][j] != nil && other[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] + other[i][j]
                    end
                end
            end
            # Almacenamiento del resultado en la matriz densa.
            c
        end
        # Metodo que realiza la resta entre matrices cuadradas.
        def -(other)
            # Error en caso de que las matrices sean de diferente tamaño.
            raise ArgumentError, "Matrix size must be equal" unless @rows == other.rows && @cols == other.cols
            # Matriz densa donde se guardara el resultado de la resta.
            c = DenseMatrix.new(@rows, @cols)
            # Recorrido de las matrices para operar.
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] == nil && other[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && other[i][j] != nil
                        c[i][j] = -other[i][j]
                    elsif self[i][j] != nil && other[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] - other[i][j]
                    end
                end
            end
            # Almacenamiento del resultado en la matriz densa.
            c
        end
        # Metodo que realiza la multiplicacion entre matrices cuadradas.
        def *(other)
            # Error en caso de que las matrices sean de diferente tamaño.
            raise ArgumentError, "Columns and Rows must be equal" unless (@cols == other.rows)
            # Matriz densa donde se guardara el resultado de la multiplicacion.
            c = DenseMatrix.new(@rows,other.cols)
            # Recorrido de las matrices para operar.
            @rows.times do |i|
                other.cols.times do |j|
                    ac = 0
                    @cols.times do |k|
                        ac += self[i][k] * other[k][j] if (self[i][k] != nil && other[k][j] != nil)
                    end
                    c[i][j] = ac
                end
            end
            # Almacenamiento del resultado en la matriz densa.
            c
        end
        # Metodo para buscar el maximo valor de los elementos de una matriz.
        def max
            encontrado = false
            value = 0
            i = -1
            # Se revisan todos los elementos de la matriz.
            while encontrado == false
                i += 1
                j = 0
                while j < self.cols
                    if self[i][j] != nil and value == 0
                        value = self[i][j]
                        encontrado = true
                        break
                    else
                        j += 1
                    end
                end
            end
            # Se recorre la matriz y se asigna un valor mayor en caso de encontrarlo a la variable value.
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] != nil && self[i][j] > value
                        value = self[i][j]
                    end
                end
            end
            # Se retorna el maximo de los elementos de la matriz.
            value
        end
        # Metodo para buscar el valor minimo de los elementos de una matriz.
        def min
            encontrado = false
            value = 0
            i = -1
            # Se revisan todos los elementos de la matriz.
            while encontrado == false
                i += 1
                j = 0
                while j < self.cols
                    if self[i][j] != nil and value == 0
                        value = self[i][j]
                        encontrado = true
                        break
                    else
                        j += 1
                    end
                end
            end
            # Se recorre la matriz y se asigna un valor menor en caso de encontrarlo a la variable value.
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] != nil && self[i][j] < value
                        value = self[i][j]
                    end
                end
            end
            # Se retorna el minimo de los elementos de la matriz.
            value
        end
    end
    # Clase encargada de matrices densas (mas del 60% de sus elementos son distintos a 0), quien hereda de la clase Matrix.
    class DenseMatrix < Matrix
        # Vector para guardar los elementos de la matriz.
        attr_reader :data
        # Constructor de la clase.
        def initialize(rows,cols)
            # Vector para guardar los elementos de la matriz.
            @data = Array.new(rows) {Array.new(cols)}
            super
        end
        # Metodo de acceso a los indices de la matriz.
        def [](i)
            @data[i]
        end
        # Metodo para asignar un valor a un indice de la matriz.
        def []=(i,value)
            @data[i] = value
        end
        # Metodo para realizar la traspuesta de la matriz.
        def tras()
            # Matriz densa donde se guardara el resultado de la trasposicion.
            c = DenseMatrix.new(@cols, @rows)
            # Reocrrido de la matriz trasponiendo los elementos.
            c.rows.times do |i|
                c.cols.times do |j|
                    c[i][j] = self[j][i]
                end
            end
            # Matriz que contiene el resultado de la trasposicion.
            c
        end
        # Metodo para multiplicar una matriz por un escalar.
        def x(value)
            self.rows.times do |i|
                self.cols.times do |j|
                    self[i][j] *= 2
                end
            end
        end
    end
    # Clase encargada de la creacion y acceso a vectores dispersos (mas del 60% de sus elementos son 0).
    class SparseVector
        # Vector para guardar los elementos.
        attr_reader :vector
        # Constructor del vector mediante hashes.
        def initialize(h = {})
            @vector = Hash.new(0)
            @vector = @vector.merge!(h)
        end
        # Metodo de acceso a los indices del vector.
        def [](i)
            @vector[i]
        end
    end
    # Clase encargada de matrices dispersas (mas del 60% de sus elementos son 0), quien hereda de la clase Matrix.
    class SparseMatrix < Matrix
        # Hash de hashes para guardar los elementos de la matriz.
        attr_reader :data
        # Constructor de la clase.
        def initialize(rows,cols, h = {})
            # Hash de hashes para guardar los elementos de la matriz.
            @data = Hash.new({})
            for k in h.keys do
                # Comprobacion de vector disperso.
                if h[k].is_a? SparseVector
                    @data[k] = h[k]
                else
                    @data[k] = SparseVector.new(h[k])
                end
            end
            super(rows,cols)
        end
        # Metodo de acceso a los indices de la matriz.
        def [](i)
            @data[i]
        end
    end
    # Clase encargada de trabajar con numeros fraccionarios.
    class Fraccion
        # Se incluye el modulo Comparable para la implementacion de operaciones posteriores.
        include Comparable

        attr_accessor :num, :denom
        # Constructor de la clase.
        def initialize(a, b)
            # Comprobacion del Maximo Comun Divisor para la simplificacion de fracciones.
            x = mcd(a,b)
            @num = a/x
            @denom = b/x
            # Comprobacion en caso de que la fraccion completa es negativa.
            if (@num < 0 && @denom < 0)
                @num = @num * -1
                @denom = @denom * -1
            end
            # Comprobacion en caso de que el denominador sea negativo.
            if (@denom < 0)
                @denom = @denom * -1
                @num = @num * -1
            end
        end
        # Metodo que se encarga de realizar el Maximo Comun Divisor para la simplifacion de fracciones.
        def mcd(u, v)
           u, v = u.abs, v.abs
           while v != 0
              u, v = v, u % v
           end
           u
        end
        # Metodo para convertir una fraccion a una cadena.
        def to_s
            "#{@num}/#{@denom}"
        end
        # Metodo para convertir una fraccion a un float.
        def to_f
            @num.to_f/@denom.to_f
        end
        # Metodo que realiza la suma entre numeros fraccionales.
        def +(other)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom + @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.denom + @denom * other.num, @denom * other.denom)
            end
        end
        # Metodo que realiza la resta entre numeros fraccionales.
        def -(other)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom - @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.denom - @denom * other.num, @denom * other.denom)
            end
        end
        # Metodo que realiza la multiplicacion entre numeros fraccionales.
        def *(other)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.num, @denom * other.denom)
            end
        end
        # Metodo que realiza la division entre numeros fraccionales.
        def /(other)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.      
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom, @denom * c.num)
            else
                Fraccion.new(@num * other.denom, @denom * other.num)
            end        
        end
        # Metodo que realiza el modulo entre numeros fraccionales.
        def %(other)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.            
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                division = Fraccion.new(@num * c.denom, @denom * c.num)
            else
                division = Fraccion.new(@num * other.denom, @denom * other.num)
            end  
            division.num % division.denom
        end
        # Metodo que almacena el valor absoluto de un numero fraccional.
        def abs
            @num = @num.abs
            @denom = @denom.abs
        end
        # Metodo que realiza el reciproco de un numero fraccional.
        def reciprocal
            x = @num
            @num = @denom
            @denom = x
        end
        # Metodo que realiza el opuesto de un numero fraccional.
        def -@
            if (@num > 0)
                @num = @num * -1
            end
        end
        # Metodo que realiza comparaciones entre numeros fraccionales.
        def <=>(other)
            return nil unless (other.instance_of? Fraccion) || (other.instance_of? Fixnum)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.            
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                (c.num.to_f/c.denom.to_f) <=> (self.num.to_f/self.denom.to_f)
            else
                (self.num.to_f/self.denom.to_f) <=> (other.num.to_f/other.denom.to_f)
            end
        end
        # Metodo para poder realizar operaciones con objetos de otra clase.
        def coerce(other)
            [self,other]
        end
    end
end