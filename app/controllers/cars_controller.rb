class CarsController < ApplicationController
  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      @cars = Car.all
      flash.now[:notice] = 'Carro cadastrado com sucesso'
      render :index
    else
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end

  def index
    @cars = Car.all
  end

  private def car_params
    params.require(:car).permit(:license_plate, :color, :car_model_id, :mileage, :subsidiary_id)
  end
end
