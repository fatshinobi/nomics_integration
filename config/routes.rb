Rails.application.routes.draw do
  get 'dashboard/index', as: :dashboard_index
  get 'dashboard/filtered', as: :dashboard_filtered
  get 'dashboard/fiats', as: :dashboard_fiats
  get 'dashboard/calculation', as: :dashboard_calculation

  root 'dashboard#index'
end
