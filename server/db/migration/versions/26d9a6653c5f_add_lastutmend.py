"""add lastutmend

Revision ID: 26d9a6653c5f
Revises: dcd3a9954b0e
Create Date: 2024-12-15 23:59:40.894187

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '26d9a6653c5f'
down_revision: Union[str, None] = 'dcd3a9954b0e'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        'flightsessions',
        sa.Column('utmlastend', sa.DateTime, nullable=True)
    )    

def downgrade() -> None:
    op.drop_column('flightsessions','utmlastend')
