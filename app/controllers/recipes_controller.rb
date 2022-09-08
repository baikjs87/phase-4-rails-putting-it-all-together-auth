class RecipesController < ApplicationController

    def index
        if session[:user_id]
            recipes = Recipe.all
            render json: recipes, include: :user, status: :created
        else
            render json: { errors: ["Unauthorized"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
        recipe = Recipe.create(recipe_params)
        render json: recipe, status: :created
        # elsif !recipe.valid?
        #     render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        # else
            # render json: { errors: ["No user logged in"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
